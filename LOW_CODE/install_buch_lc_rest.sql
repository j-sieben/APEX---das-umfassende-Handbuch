prompt * Create Views
prompt - View dl_hr_employees
create or replace view dl_hr_employees as
select *
  from buch_lc_data.hr_employees;

prompt - View dl_hr_departments
create or replace view dl_hr_departments as
select *
  from buch_lc_data.hr_departments;

prompt - View dl_hr_jobs
create or replace view dl_hr_jobs as
select *
  from buch_lc_data.hr_jobs;


create or replace package hr 
  authid definer
as

  procedure get_employee(
    p_format in varchar2 default apex_data_export.c_format_html,
    p_emp_id in dl_hr_employees.emp_id%type default null);
    
end hr;
/


create or replace package body hr
as
  e_prerequisistes_not_met exception;
  pragma exception_init (e_prerequisistes_not_met, -20999);
  
  C_CHUNK_SIZE constant integer := 8192;
  
  subtype max_char is varchar2(32767);

  /**
    Procedure: print_clob
      Method passes a CLOB text to APEX, using HTP.P.
      CLOB is splitted into chunks of <C_CHUNK_SIZE> bytes to circumvent the limitation of http streams of 32 KByte.

    Parameter:
      p_text - CLOB instance to pass to APEX
   */
  procedure print_clob(
    p_text in clob)
  as
    l_offset binary_integer := 1;
    l_amount binary_integer := C_CHUNK_SIZE;
    l_chunk max_char;
    l_length binary_integer := dbms_lob.getlength(p_text);
  begin
    while l_length > 0 and p_text is not null loop
      dbms_lob.read(
        lob_loc => p_text,
        amount => l_amount,
        offset => l_offset,
        buffer => l_chunk);
      l_offset := l_offset + l_amount;
      l_length := l_length - l_amount;
      sys.htp.p(l_chunk);
    end loop;
  end print_clob;
  
  
  /**
    Procedure: check_export_format

    Parameter:
      p_format - Format to check

    Raises: e_prerequisistes_not_met if p_format does not contain an allowed export format
   */
  procedure check_export_format(
    p_format in varchar2)
  as
  begin
    if upper(p_format) not in ('CSV', 'HTML', 'PDF', 'XLSX', 'XML', 'PXML', 'JSON', 'PJSON') then
      htp.p('Ungültiges Format ' || p_format || ' übergeben. Derzeit werden die Formate CSV, HTML, PDF, XLSX, XML, PXML, JSON, PJSON unterstützt');
      raise e_prerequisistes_not_met;
    end if;
  end check_export_format;


  /**
    Procedure: set_apex_session

    Raises: e_prerequisistes_not_met if an APEX session could not be established
   */
  procedure set_apex_session
  as
    l_application_id binary_integer;
    l_page_id binary_integer;
  begin
    select application_id, page_id
      into l_application_id, l_page_id
      from apex_application_pages
     where rownum = 1;
    apex_session.create_session(l_application_id, l_page_id, 'FOO');
  exception
    when NO_DATA_FOUND then
      htp.p('Es existiert keine APEX-Anwendung, für die eine Session eingerichtet werden kann. Dieser Service setzt dies voraus.');
      raise e_prerequisistes_not_met;
  end set_apex_session;


  procedure get_employee(
    p_format in varchar2 default apex_data_export.c_format_html,
    p_emp_id in dl_hr_employees.emp_id%type default null)
  as  
    l_context apex_exec.t_context;
    l_export apex_data_export.t_export;
    l_query varchar2(1000 byte) := q'^
       select emp_id, emp_first_name, emp_last_name, emp_hire_date,
              emp_salary, job_title, dep_id, dep_name,
              case when instr(job_title, 'Manager') > 0 then 1 end row_highlight,
              case when emp_salary > 10000 then 2 end column_highlight,
              sum(emp_salary) over (partition by dep_id) dep_salary,
              sum(emp_salary) over () total_salary
         from dl_hr_employees
         join dl_hr_departments
           on emp_dep_id = dep_id
         join dl_hr_jobs
           on emp_job_id = job_id
        where emp_id = :EMP_ID or :EMP_ID is null
        order by dep_id^';
    l_columns apex_data_export.t_columns;
    l_highlights apex_data_export.t_highlights;
    l_aggregates apex_data_export.t_aggregates;
    l_parameters apex_exec.t_parameters;
  begin
    check_export_format(p_format);
    set_apex_session;

    apex_exec.add_parameter(
      l_parameters, 'EMP_ID', p_emp_id);
      
    l_context := apex_exec.open_query_context(
                   p_location => apex_exec.c_location_local_db,
                   p_sql_query => l_query,
                   p_sql_parameters => l_parameters);

    apex_data_export.add_column(
      p_columns => l_columns,
      p_name => 'DEP_ID',
      p_heading => 'Abteilung-ID',
      p_is_column_break => true);

    apex_data_export.add_column(
      l_columns, 'DEP_NAME', 'Abteilung', p_is_column_break => true);
    apex_data_export.add_column(l_columns, 'EMP_ID', 'Mitarbeiter-Nr.');
    apex_data_export.add_column(l_columns, 'EMP_FIRST_NAME', 'Vorname');
    apex_data_export.add_column(l_columns, 'EMP_LAST_NAME', 'Nachname');
    apex_data_export.add_column(
      l_columns, 'EMP_HIRE_DATE', 'Einstelldatum', 
      p_format_mask => 'dd.mm.yyyy');
    apex_data_export.add_column(l_columns, 'EMP_SALARY', 'Gehalt', 'fm999G999G990D00');
    apex_data_export.add_column(l_columns, 'JOB_TITLE', 'Beruf');

    apex_data_export.add_highlight(
      p_highlights => l_highlights,
      p_id => 1,
      p_value_column => 'ROW_HIGHLIGHT',
      p_background_color => '#D0F1CC');

    apex_data_export.add_highlight(
      p_highlights => l_highlights,
      p_id => 2,
      p_value_column => 'COLUMN_HIGHLIGHT',
      p_display_column => 'EMP_SALARY',
      p_background_color => '#D0F1CC');

    apex_data_export.add_aggregate(
      p_aggregates => l_aggregates,
      p_format_mask => 'FM999G999G999G999G990D00',
      p_display_column => 'EMP_SALARY',
      p_label => 'Summe',
      p_value_column => 'DEP_SALARY',
      p_overall_label => 'Gesamtsumme',
      p_overall_value_column => 'TOTAL_SALARY');

    l_export := apex_data_export.export(
                  p_context => l_context,
                  p_format => p_format,
                  p_as_clob => true,
                  p_columns => l_columns,
                  p_highlights => l_highlights,
                  p_aggregates => l_aggregates);

    apex_exec.close(l_context);
    apex_session.delete_session;

    print_clob(l_export.content_clob);
  exception
    when e_prerequisistes_not_met then
      null;      
  end get_employee;
  
end hr;
/


prompt * WebServices
prompt - HR Service
begin

  ords.enable_schema(
    p_enabled => true,
    p_schema => 'BUCH_LC_REST',
    p_url_mapping_type => 'BASE_PATH',
    p_url_mapping_pattern => 'rest_v2',
    p_auto_rest_auth => false);    
  
  ords.define_module(
    p_module_name => 'hr',
    p_base_path => 'hr/',
    p_items_per_page => 0);
  
  ords.define_template(
   p_module_name => 'hr',
   p_pattern => 'employee/:format/');

  ords.define_handler(
    p_module_name => 'hr',
    p_pattern => 'employee/:format/',
    p_method => 'GET',
    p_source_type => ords.source_type_plsql,
    p_source => 'begin hr.get_employee(:format, null); end;',
    p_items_per_page => 0);
    
  ords.define_template(
   p_module_name => 'hr',
   p_pattern => 'employee/:format/:empno');

  ords.define_handler(
    p_module_name => 'hr',
    p_pattern => 'employee/:format/:empno',
    p_method => 'GET',
    p_source_type => ords.source_type_plsql,
    p_source => 'begin hr.get_employee(:format, :empno); end;',
    p_items_per_page => 0);

  commit;
end;
/
