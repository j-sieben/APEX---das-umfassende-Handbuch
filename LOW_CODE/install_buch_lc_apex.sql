define LC_APEX = BUCH_LC_APEX
define LC_DATA = BUCH_LC_DATA

prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_210200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
  wwv_flow_api.import_begin (
    p_version_yyyy_mm_dd=>'2021.10.15',
    p_default_workspace_id=>17504259117959332
  );
end;
/
prompt  WORKSPACE 17504259117959332
--
-- Workspace, User Group, User, and Team Development Export:
--   Date and Time:   09:35 Sonntag August 28, 2022
--   Exported By:     BUCH_ADMIN
--   Export Type:     Workspace Export
--   Version:         21.2.0
--   Instance ID:     697966460776679
--
-- Import:
--   Using Instance Administration / Manage Workspaces
--   or
--   Using SQL*Plus as the Oracle user APEX_210200
 
begin
  wwv_flow_api.set_security_group_id(
    p_security_group_id=>17504259117959332);
end;
/
----------------
-- W O R K S P A C E
-- Creating a workspace will not create database schemas or objects.
-- This API creates only the meta data for this APEX workspace
prompt  Creating workspace BUCH_LOW_CODE...
begin
  wwv_flow_fnd_user_api.create_company (
    p_id => 17504388061959343
   ,p_provisioning_company_id => 17504259117959332
   ,p_short_name => 'BUCH_LOW_CODE'
   ,p_display_name => 'BUCH_LOW_CODE'
   ,p_first_schema_provisioned => 'BUCH_LC_APEX'
   ,p_company_schemas => 'BUCH_LC_APEX'
   ,p_account_status => 'ASSIGNED'
   ,p_allow_plsql_editing => 'Y'
   ,p_allow_app_building_yn => 'Y'
   ,p_allow_packaged_app_ins_yn => 'Y'
   ,p_allow_sql_workshop_yn => 'Y'
   ,p_allow_websheet_dev_yn => 'Y'
   ,p_allow_team_development_yn => 'Y'
   ,p_allow_to_be_purged_yn => 'Y'
   ,p_allow_restful_services_yn => 'Y'
   ,p_source_identifier => 'BUCH_LOW'
   ,p_webservice_logging_yn => 'Y'
   ,p_path_prefix => 'HR'
   ,p_files_version => 1
   ,p_env_banner_yn => 'N'
   ,p_env_banner_pos => 'LEFT'
  );
end;
/
----------------
-- G R O U P S
--
prompt  Creating Groups...
begin
  wwv_flow_fnd_user_api.create_user_group (
    p_id => 2400655054815034,
    p_GROUP_NAME => 'OAuth2 Client Developer',
    p_SECURITY_GROUP_ID => 10,
    p_GROUP_DESC => 'Users authorized to register OAuth2 Client Applications');
    
    p_id => 2400523155815034,
    p_GROUP_NAME => 'RESTful Services',
    p_SECURITY_GROUP_ID => 10,
    p_GROUP_DESC => 'Users authorized to use RESTful Services with this workspace');
    
  wwv_flow_fnd_user_api.create_user_group (
    p_id => 2400469814815034,
    p_GROUP_NAME => 'SQL Developer',
    p_SECURITY_GROUP_ID => 10,
    p_GROUP_DESC => 'Users authorized to use SQL Developer with this workspace');
end;
/
prompt  Creating group grants...
----------------
-- U S E R S
-- User repository for use with APEX cookie-based authentication.
--
prompt  Creating Users...
begin
  wwv_flow_fnd_user_api.create_fnd_user (
    p_user_id                      => '17504164753959332',
    p_user_name                    => 'BUCH_ADMIN',
    p_first_name                   => 'Jürgen',
    p_last_name                    => 'Sieben',
    p_description                  => '',
    p_email_address                => 'j.sieben@condes.de',
    p_web_password                 => 'DF1C15867E8ED8A91CBF29BDDF040CDF5A3801A98F7F8F4AC2C654F6B058E1125D68F73B5B3158BACFE2619450A9A45C893DB225F213FA3B697885469CF23DFA',
    p_web_password_format          => '5;5;10000',
    p_group_ids                    => '',
    p_developer_privs              => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
    p_default_schema               => 'BUCH_LC_APEX',
    p_account_locked               => 'N',
    p_account_expiry               => to_date('202208201014','YYYYMMDDHH24MI'),
    p_failed_access_attempts       => 0,
    p_change_password_on_first_use => 'N',
    p_first_password_use_occurred  => 'Y',
    p_allow_app_building_yn        => 'Y',
    p_allow_sql_workshop_yn        => 'Y',
    p_allow_websheet_dev_yn        => 'N',
    p_allow_team_development_yn    => 'Y',
    p_allow_access_to_schemas      => '');
    
  wwv_flow_fnd_user_api.create_fnd_user (
    p_user_id                      => '17511966039993832',
    p_user_name                    => 'BUCH_ANWENDER',
    p_first_name                   => '',
    p_last_name                    => '',
    p_description                  => '',
    p_email_address                => 'foo@web.de',
    p_web_password                 => 'BEB1E6417C3BFAF80484008375743FD195466825B7D91E6156D1720694BE58900B1FB0D6115A96D3A2BD886F9521E4E30FAC2572CD49C4661B87A95DFF3B0B49',
    p_web_password_format          => '5;5;10000',
    p_group_ids                    => '',
    p_developer_privs              => '',
    p_default_schema               => 'BUCH_LC_APEX',
    p_account_locked               => 'N',
    p_account_expiry               => to_date('202207120000','YYYYMMDDHH24MI'),
    p_failed_access_attempts       => 0,
    p_change_password_on_first_use => 'N',
    p_first_password_use_occurred  => 'N',
    p_allow_app_building_yn        => 'N',
    p_allow_sql_workshop_yn        => 'N',
    p_allow_websheet_dev_yn        => 'N',
    p_allow_team_development_yn    => 'N',
    p_allow_access_to_schemas      => '');
    
  wwv_flow_fnd_user_api.create_fnd_user (
    p_user_id                      => '17512123893995981',
    p_user_name                    => 'BUCH_ENTWICKLER',
    p_first_name                   => '',
    p_last_name                    => '',
    p_description                  => '',
    p_email_address                => 'foo@web.de',
    p_web_password                 => '2F4EAB18CE01553666BF7F5A96858867D75380D73CA41D2AE1C219BC23ACC3DD6C71097514A46917D04590A52C0E3B8A4D06289272B6F6038DE1CFB226B69F79',
    p_web_password_format          => '5;5;10000',
    p_group_ids                    => '',
    p_developer_privs              => '',
    p_default_schema               => 'BUCH_LC_APEX',
    p_account_locked               => 'N',
    p_account_expiry               => to_date('202207120000','YYYYMMDDHH24MI'),
    p_failed_access_attempts       => 0,
    p_change_password_on_first_use => 'Y',
    p_first_password_use_occurred  => 'N',
    p_allow_app_building_yn        => 'N',
    p_allow_sql_workshop_yn        => 'N',
    p_allow_websheet_dev_yn        => 'N',
    p_allow_team_development_yn    => 'N',
    p_allow_access_to_schemas      => '');
end;
/
prompt Check Compatibility...
begin
  -- This date identifies the minimum version required to import this file.
  wwv_flow_team_api.check_version(
    p_version_yyyy_mm_dd=>'2010.05.13');
end;
/
 
begin 
  wwv_flow.g_import_in_progress := true; 
  wwv_flow.g_user := USER; 
end; 
/
 
begin
  wwv_flow_api.import_end(
    p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
  commit;
end;
/
set verify on feedback on define on
prompt  ...done


prompt * Erzeuge Synonyme, falls erforderlich
declare
  cursor granted_objects_cur is
    select 'create or replace synonym ' || object_name || ' for ' || owner || '.' || object_name script
      from all_objects
     where owner = '&LC_DATA.'
       and object_type in ('TABLE', 'VIEW', 'PACKAGE')
       and '&LC_APEX.' != '&LC_DATA.';
begin
  for obj in granted_objects_cur loop
    execute immediate obj.script;
  end loop;
end;
/

prompt * Erstelle Views
prompt . EMP_UI_DEPT_OVERVIEW_EMPLOYEES
create or replace view emp_ui_dept_overview_employees as
select emp_id, emp_first_name, emp_last_name, emp_email, emp_phone_number, emp_hire_date, emp_job_id, emp_salary, emp_commission_pct, emp_mgr_id, emp_dep_id
  from hr_employees;
  
  
prompt . EMP_UI_DEPT_OVERVIEW_LOCATIONS
create or replace view emp_ui_dept_overview_locations as
select loc_id, loc_street_address, loc_postal_code, loc_city, loc_state_province, cou_name
  from hr_locations
  join hr_countries
    on loc_cou_id = cou_id
 where exists(
       select null
         from hr_departments
        where dep_loc_id = loc_id);
  
prompt . EMP_UI_DEPT_OVERVIEW_MASTER
create or replace view emp_ui_dept_overview_master as
select dep_id, dep_name, dep_mgr_id, dep_loc_id
  from hr_departments;
  
  
prompt .  EMP_UI_EMP_ADMIN_MAIN
create or replace view emp_ui_emp_admin_main as
select emp_id,
       emp_first_name,
       emp_last_name,
       emp_hire_date,
       emp_salary,
       job_title,
       dep_id,
       dep_name
  from hr_employees
  join hr_jobs on emp_job_id = job_id
  left join hr_departments on emp_dep_id = dep_id;
  
prompt .  EMP_UI_EMP_ADMIN_MAIN_ICON
create or replace view emp_ui_emp_admin_main_icon as
select emp_id,
       emp_first_name,
       emp_last_name,
       job_title,
       dep_id,
       dep_name,
       case (select count(*) is_manager
         from dual
        where exists(
              select null
                from hr_employees m
               where m.emp_mgr_id = e.emp_id)) when 1 then 'fa-check' else 'fa-times' end is_manager,
       coalesce(loc_city || ', ' || loc_street_address, 'ohne Abteilung') emp_last_name_title
  from hr_employees e
  join hr_jobs on emp_job_id = job_id
  left join hr_departments on emp_dep_id = dep_id
  left join hr_locations on dep_loc_id = loc_id;
  
prompt . EMP_UI_EMP_LOAD_EXCEPTIONS
create or replace view emp_ui_emp_load_exceptions as
select n001 row_pointer, substr(c001, 12) error_message
  from apex_collections
 where collection_name = 'HR_EMPLOYEES_EXCEPTIONS';
  
prompt . EMP_UI_EMP_LOAD_EMAIN
create or replace view emp_ui_emp_load_main as
with params as (
       select /*+ no_merge */ v('P2_FILE') p_file,
              v('P2_XLSX_WORKSHEET') p_xsls_worksheet,
              'Mitarbeiterliste' p_static
         from dual)
select line_number,
       col001, col002, col003, col004, col005, col006, col007, col008, col009, col010
       -- add more columns (col011 to col300) here.
  from apex_application_temp_files
  join params p
    on name = p_file
 cross join table( 
         apex_data_parser.parse(
           p_content => blob_content,
           p_file_name => filename,
           p_xlsx_sheet_name => case when p_xsls_worksheet is not null then p_xsls_worksheet end,
           p_file_profile => apex_data_loading.get_file_profile(p_static_id => p_static),
           p_max_rows => 100));
  
prompt .  EMP_UI_REPORT_MAIN
create or replace view emp_ui_report_main as
select emp_id,
       emp_first_name,
       emp_last_name,
       emp_email,
       emp_phone_number,
       emp_salary,
       job_title emp_job_name,
       coalesce(dep_name, 'Zusatz: Ohne Abteilung') emp_dep_name
  from hr_employees emp
  join hr_jobs job on emp_job_id = job_id
  left join hr_departments dep on emp_dep_id = dep_id;
  
prompt . EMP_UI_FACET
create or replace view emp_ui_facet as
select emp_id, emp_first_name, emp_last_name, emp_email, emp_phone_number, emp_hire_date, emp_job_id, job_title emp_job_title,
       emp_salary, emp_commission_pct, emp_mgr_id, emp_dep_id, dep_name emp_department,
       case when emp_commission_pct is null then 0 else 1 end emp_is_commission_eligible,
       (select count(*) 
         from dual 
        where exists(
              select null 
                from hr_employees m 
               where m.emp_mgr_id = e.emp_id)) emp_is_manager
  from hr_employees e
  join hr_jobs
    on emp_job_id = job_id
  join hr_departments
    on emp_dep_id = dep_id;
 
prompt .  EMP_UI_HOME_ALERTS
create or replace view emp_ui_home_alerts as
select case when emp_salary = job_min_salary then 'warning' else 'success' end alert_type,
       case when emp_salary = job_min_salary then 'Gehalt am Minimum' else 'Gehalt am Maximum' end alert_title,
       emp_first_name || ' ' || emp_last_name || ', ' || job_title alert_desc,
       case when emp_salary = job_min_salary then 'Gehaltssteigerung prüfen' else 'Beförderung prüfen' end alert_action
  from hr_employees
  join hr_jobs
    on emp_job_id = job_id
 where emp_salary > job_max_salary - (job_max_salary * 0.05)
    or emp_salary = job_min_salary;
 
prompt .  EMP_UI_HOME_BADGES
create or replace view emp_ui_home_badges as
with data as(
       select initcap(substr(job_id, 4)) job_title
         from hr_employees
         join hr_jobs
           on emp_job_id = job_id)
select account, department_manager, assistant, president, vice_president, programmer, representative, clerk, manager
  from data
 pivot (
       count(*) for job_title in (
         'Account' account, 
         'Mgr' department_manager, 
         'Asst' assistant, 
         'Pres' president, 
         'Vp'vice_president, 
         'Prog' programmer, 
         'Rep' representative, 
         'Clerk' clerk, 
         'Man' manager));
 
prompt .  EMP_UI_HOME_CHART
create or replace view emp_ui_home_chart as
select count(emp_id) emp_amount, cou_id, cou_name
  from hr_employees
  join hr_departments on emp_dep_id = dep_id
  join hr_locations on dep_loc_id = loc_id 
  join hr_countries on loc_cou_id = cou_id
 group by cou_id, cou_name;

prompt .  EMP_UI_HOME_COUNT
create or replace view emp_ui_home_count as
select cou_name, count (distinct l.loc_id) loc_amount, count(distinct d.dep_id) dep_amount, count(e.emp_id) emp_amount
  from hr_countries c
  join hr_locations l on c.cou_id = l.loc_cou_id
  join hr_departments d on l.loc_id = d.dep_loc_id
  join hr_employees e on d.dep_id = e.emp_dep_id
 group by cou_name
 order by emp_amount desc;
 
prompt .  EMP_UI_LOV_DEPARTMENTS
create or replace view emp_ui_lov_departments as
select dep.dep_name display_name, dep.dep_id return_value, 
       case when emp.emp_dep_id is not null then 1 else 0 end dep_has_employee
  from hr_departments dep
  left join (
       select dep_id emp_dep_id
         from hr_departments d
        where exists (
              select 1
                from hr_employees e
               where e.emp_dep_id = d.dep_id))emp
    on dep.dep_id = emp.emp_dep_id;

prompt .  EMP_UI_LOV_EMPLOYEES
create or replace view emp_ui_lov_employees as
select emp.emp_last_name || ', ' || emp.emp_first_name display_name, emp.emp_id return_value,
       case when mgr.emp_id is not null then 1 else 0 end emp_is_manager
  from hr_employees emp
  left join
       (select emp_id
          from hr_employees m
         where exists(
               select 1
                 from hr_employees e
                where e.emp_mgr_id = m.emp_id)) mgr
    on emp.emp_id = mgr.emp_id;
 
prompt .  EMP_UI_LOV_JOBS
create or replace view emp_ui_lov_jobs as
select job_title display_name, job_id return_value
  from hr_jobs;
    
prompt .  EMP_UI_LOV_SALARY_RANGES
create or replace view emp_ui_lov_salary_ranges as
with data as(
       select emp_salary, ntile(5) over (order by emp_salary) emp_salary_range
         from hr_employees)
select to_char(min(emp_salary), 'fm999G990') || ' - ' || to_char(coalesce((lead(min(emp_salary)) over (order by min(emp_salary)) - 1), max(emp_salary)), 'fm999G990') range_display, 
       min(emp_salary) || '|' || coalesce((lead(min(emp_salary)) over (order by min(emp_salary)) - 1), max(emp_salary)) range
  from data
 group by emp_salary_range;
 
prompt .  EMP_UI_LOV_COUNTRIES
create or replace view emp_ui_lov_countries as
select cou_name display_name, cou_id return_value
  from hr_countries;
 
prompt .  EMP_UI_LOV_LOCATIONS
create or replace view emp_ui_lov_locations as
select loc_city display_name, loc_id return_value, cou_name country
  from hr_locations
  join hr_countries
    on loc_cou_id = cou_id;
 
prompt .  EMP_UI_REPORT_MAIN
create or replace view emp_ui_report_main as
select emp_id,
       emp_first_name,
       emp_last_name,
       emp_email,
       emp_phone_number,
       job_title emp_job_name,
       coalesce(dep_name, 'Zusatz: Ohne Abteilung') emp_dep_name
  from hr_employees emp
  join hr_jobs job on emp_job_id = job_id
  left join hr_departments dep on emp_dep_id = dep_id;
 
prompt .  EMP_UI_SEARCH_RESULT
create or replace view emp_ui_search_result as
select emp_dep_id,
       apex_page.get_url(
         p_page => 'EMP_EDIT',
         p_items => 'P5_EMP_ID',
         p_values => emp_id) search_link,
       emp_last_name || ', ' || emp_first_name search_title,
       job_title || ', ' || dep_name search_desc,
       'Einstelldatum' label_01,
       to_char(emp_hire_date, 'dd.mm.yyyy') value_01,
       case when emp_commission_pct is not null then 'Boni' end label_02,
       (emp_commission_pct * 100) || '%' value_02,
       null label_03,
       null value_03
  from hr_employees
  join hr_jobs on emp_job_id = job_id
  join hr_departments
    on emp_dep_id = dep_id;
  
prompt .  EMP_UI_LOC_ADMIN
create or replace view emp_ui_loc_admin as
select loc_id, loc_street_address, loc_postal_code, loc_city, loc_state_province, 
       cou_name loc_country_name
  from hr_locations
  join hr_countries
    on loc_cou_id = cou_id;
    
prompt . EMP_UI_LOC_EDIT
create or replace view emp_ui_loc_edit as
select loc_id, loc_street_address, loc_postal_code, loc_city, loc_state_province, loc_cou_id, loc_geometry
  from hr_locations;

prompt . EMP_UI_LOC_ADMIN_CARDS
create or replace view emp_ui_loc_admin_cards as
select loc_id, 
       cou_name || ', ' || loc_city loc_headline,
       loc_street_address,
       loc_postal_code || ' ' || loc_city loc_address,
       loc_department_list,
       coalesce(to_char(l.loc_geometry.sdo_point.x, '9990.999999'), '0.0') loc_longitude,
       coalesce(to_char(l.loc_geometry.sdo_point.y, '9990.999999'), '0.0') loc_latitude
  from hr_locations l
  join hr_countries
    on loc_cou_id = cou_id
  join (
       select dep_loc_id, listagg(dep_name, ',') within group (order by dep_name) loc_department_list
         from hr_departments
        group by dep_loc_id)
    on loc_id = dep_loc_id;
    

prompt . EMP_UI_EMP_EDIT
create or replace view emp_ui_emp_edit as
select emp_id, emp_first_name, emp_last_name, emp_email, emp_phone_number,emp_hire_date,
       emp_job_id, emp_salary, emp_commission_pct, emp_mgr_id, emp_dep_id
  from hr_employees;
  
  
prompt . EMP_UI_DEP_EMP_STEP1
create or replace view emp_ui_dep_emp_step1 as
select dep_id, dep_name, dep_loc_id
  from hr_departments;
  
  
prompt . EMP_UI_DEP_EMP_STEP2
create or replace view emp_ui_dep_emp_step2 as
select seq_id,
       n001 emp_id,
       c001 emp_first_name,
       c002 emp_last_name,
       c003 emp_email,
       c004 emp_phone_number,
       d001 emp_hire_date,
       c005 emp_job_id,
       n002 emp_salary,
       n003 emp_commission_pct,
       n004 emp_mgr_id,
       n005 emp_dep_id
  from apex_collections
 where collection_name = 'EMP_UI_DEP_EMP_STEP2';  

 
prompt . BL_EMP_COLL_DELTA_VIEW
create or replace view bl_emp_coll_delta_view as
select coalesce(c.emp_id, e.emp_id) emp_id, c.emp_first_name, c.emp_last_name, c.emp_email,
       c.emp_phone_number, c.emp_hire_date, c.emp_job_id, c.emp_salary, c.emp_commission_pct,
       c.emp_mgr_id, c.emp_dep_id,
       case when e.emp_id is null then emp_ui.c_insert
            when c.emp_id is null then emp_ui.c_delete
            else emp_ui.c_update end dml_action
  from (select *
          from hr_employees
         where emp_dep_id = (select to_number(v('P9_DEP_ID')) from dual)) e
  full join emp_ui_dep_emp_step2 c
    on (e.emp_id = c.emp_id)
 where decode(e.emp_first_name, c.emp_first_name, 0, 1) +
       decode(e.emp_last_name, c.emp_last_name, 0, 1) +
       decode(e.emp_email, c.emp_email, 0, 1) +
       decode(e.emp_phone_number, c.emp_phone_number, 0, 1) +
       decode(e.emp_hire_date, c.emp_hire_date, 0, 1) +
       decode(e.emp_job_id, c.emp_job_id, 0, 1) +
       decode(e.emp_salary, c.emp_salary, 0, 1) +
       decode(e.emp_commission_pct, c.emp_commission_pct, 0, 1) +
       decode(e.emp_mgr_id, c.emp_mgr_id, 0, 1) +
       decode(e.emp_dep_id, c.emp_dep_id, 0, 1) > 0;
 
prompt . EMP_UI_DEP_EMP_STEP3_DEPT
create or replace view emp_ui_dep_emp_step3_dept as
with session_state as (
       select /*+ no_merge */ 
              v('P9_DEP_NAME') dep_name,
              v('P9_DEP_LOC_ID') dep_loc_id
         from dual)
select dep_name department, loc_city city, cou_name country
  from session_state
  join hr_locations 
    on dep_loc_id = loc_id
  join hr_countries
    on loc_cou_id = cou_id;
  
prompt . EMP_UI_DEP_EMP_STEP3_EMP
create or replace view emp_ui_dep_emp_step3_emp as
select emp_id, emp_first_name, emp_last_name, emp_email,
       emp_phone_number, emp_job_id, emp_salary,
       case dml_action 
         when emp_ui.c_insert then 'fa-plus-square-o u-success-text'
         when emp_ui.c_delete then 'fa-minus-square-o u-danger-text'
         else 'fa-edit u-info-text' end dml_action
  from bl_emp_coll_delta_view;
 
    
prompt * Erstelle Packages
prompt . EMP_UI
create or replace package emp_ui
  authid definer
as
  subtype flag_type is char(1 byte);
  subtype ora_name_type is varchar2(128 byte);
  
  function c_true
    return flag_type;
    
  function c_false
    return flag_type;

  function check_email_is_unique(
    p_emp_id in varchar2,
    p_emp_email in varchar2)
  return flag_type;

  function job_is_commission_eligible(
    p_job_id in varchar2)
    return flag_type;
  
  procedure process_emp_edit(
    p_emp_id in varchar2,
    p_emp_first_name in varchar2,
    p_emp_last_name in varchar2,
    p_emp_email in varchar2,
    p_emp_phone_number in varchar2,
    p_emp_hire_date in varchar2,
    p_emp_job_id in varchar2,
    p_emp_salary in varchar2,
    p_emp_commission_pct in varchar2,
    p_emp_mgr_id in varchar2,
    p_emp_dep_id in varchar2);
    
    
  procedure export_data(
    p_static_id in ora_name_type,
    p_format in varchar2);
    
    
  function validate_dep_emp_step1
    return boolean;
    
    
  procedure process_dep_emp_step2(
    p_seq_id in number,
    p_emp_id in varchar2,
    p_emp_first_name in varchar2,
    p_emp_last_name in varchar2,
    p_emp_email in varchar2,
    p_emp_phone_number in varchar2,
    p_emp_hire_date in varchar2,
    p_emp_job_id in varchar2,
    p_emp_salary in varchar2,
    p_emp_commission_pct in varchar2,
    p_emp_mgr_id in varchar2,
    p_emp_dep_id in varchar2);
    
    
  procedure initialize_dep_emp_collection(
    p_dep_id in emp_ui_dep_emp_step2.emp_dep_id%type);
    
end emp_ui;
/

   
prompt . EMP_UI Body
create or replace package body emp_ui
as
  
  C_COLLECTION_NAME constant ora_name_type := 'EMP_UI_DEP_EMP_STEP2';

  /** Hilfsmethoden */
  procedure add_member(
    p_row in out nocopy emp_ui_dep_emp_step2%rowtype)
  as
  begin
    p_row.seq_id := 
    apex_collection.add_member(
      p_collection_name => C_COLLECTION_NAME,
      p_n001 => p_row.emp_id,
      p_c001 => p_row.emp_first_name,
      p_c002 => p_row.emp_last_name,
      p_c003 => p_row.emp_email,
      p_c004 => p_row.emp_phone_number,
      p_d001 => p_row.emp_hire_date,
      p_c005 => p_row.emp_job_id,
      p_n002 => p_row.emp_salary,
      p_n003 => p_row.emp_commission_pct,
      p_n004 => p_row.emp_mgr_id,
      p_n005 => p_row.emp_dep_id,
      p_generate_md5 => C_FALSE);
  end add_member;
  
  procedure update_member(
    p_row in emp_ui_dep_emp_step2%rowtype)
  as
  begin
    apex_collection.update_member(
      p_seq => p_row.seq_id,
      p_collection_name => C_COLLECTION_NAME,
      p_n001 => p_row.emp_id,
      p_c001 => p_row.emp_first_name,
      p_c002 => p_row.emp_last_name,
      p_c003 => p_row.emp_email,
      p_c004 => p_row.emp_phone_number,
      p_d001 => p_row.emp_hire_date,
      p_c005 => p_row.emp_job_id,
      p_n002 => p_row.emp_salary,
      p_n003 => p_row.emp_commission_pct,
      p_n004 => p_row.emp_mgr_id,
      p_n005 => p_row.emp_dep_id);
  end update_member;
  
  procedure delete_member(
    p_seq_id in number)
  as
  begin
    apex_collection.delete_member(
      p_seq => p_seq_id,
      p_collection_name => C_COLLECTION_NAME);
  end delete_member;


  /** INTERFACE */
  function c_true
    return flag_type
  as
  begin
    return 'Y';
  end c_true;
  
  
  function c_false
    return flag_type
  as
  begin
    return 'N';
  end c_false;
  

  function check_email_is_unique(
    p_emp_id in varchar2,
    p_emp_email in varchar2)
  return flag_type
  as
   l_email_found flag_type;
  begin
    select case count(*) when 1 then emp_ui.c_true else emp_ui.c_false end
      into l_email_found
      from hr_employees 
     where emp_email = p_emp_email
       and emp_id != p_emp_id;
       
    return l_email_found;
  end check_email_is_unique;
  
       
  function job_is_commission_eligible(
    p_job_id in varchar2)
    return flag_type
  as
    l_job_is_commission_eligible hr_jobs.job_is_commission_eligible%type;
  begin
    select job_is_commission_eligible
      into l_job_is_commission_eligible
      from hr_jobs
     where job_id = p_job_id;
    
    return l_job_is_commission_eligible;
  exception
    when NO_DATA_FOUND then
      return c_false;
  end job_is_commission_eligible;
  

  procedure process_emp_edit(
    p_emp_id in varchar2,
    p_emp_first_name in varchar2,
    p_emp_last_name in varchar2,
    p_emp_email in varchar2,
    p_emp_phone_number in varchar2,
    p_emp_hire_date in varchar2,
    p_emp_job_id in varchar2,
    p_emp_salary in varchar2,
    p_emp_commission_pct in varchar2,
    p_emp_mgr_id in varchar2,
    p_emp_dep_id in varchar2)
  as
    l_row hr_employees%rowtype;
  begin
    -- Daten typsicher umkopieren
    l_row.emp_id := to_number(p_emp_id);
    l_row.emp_first_name := p_emp_first_name;
    l_row.emp_last_name := p_emp_last_name;
    l_row.emp_email := upper(trim(p_emp_email));
    l_row.emp_phone_number := p_emp_phone_number;
    l_row.emp_hire_date := to_date(p_emp_hire_date, 'dd.mm.yyyy');
    l_row.emp_job_id := p_emp_job_id;
    l_row.emp_salary := to_number(p_emp_salary, '999999999D99');
    l_row.emp_commission_pct := to_number(p_emp_commission_pct, '99D99');
    l_row.emp_mgr_id := to_number(p_emp_mgr_id);
    l_row.emp_dep_id := p_emp_dep_id;
    
    if v('APEX$ROW_STATUS') = 'D' then
      bl_emp.delete_employee(l_row);
    else
      bl_emp.merge_employee(l_row);
    end if; 
    
  end process_emp_edit;
  
  
  procedure export_data(
    p_static_id in ora_name_type,
    p_format in varchar2)
  as
    l_application_id number := apex_application.g_flow_id;
    l_page_id number := apex_application.g_flow_step_id;
    l_export apex_data_export.t_export;
    l_region_id number;
    e_wrong_format exception;
    pragma exception_init(e_wrong_format, -20000);
  begin
    if upper(p_format) not in (
        'CSV', 'HTML', 'PDF', 'XLSX', 'XML', 'PXML', 'JSON', 'PJSON') then
        raise e_wrong_format;
    end if;
  
    select region_id
      into l_region_id
      from apex_application_page_regions
     where application_id = l_application_id
       and page_id = l_page_id
       and static_id = p_static_id;
    l_export := apex_region.export_data(
                  p_format => p_format,
                  p_page_id => l_application_id,
                  p_region_id => l_region_id);
    apex_data_export.download(
      p_export => l_export);
  exception
    when e_wrong_format then
      apex_error.add_error(
        p_message => 'Ungültiges Format ' || p_format || ' übergeben',
        p_additional_info => 'Derzeit werden die Formate CSV, HTML, PDF, XLSX, XML, PXML, JSON, PJSON unterstützt (siehe APEX_DATA_EXPORT.C_FORMAT...',
        p_display_location => apex_error.c_on_error_page);
    when NO_DATA_FOUND then 
      apex_error.add_error(
        p_message => 'Der Bericht ' || p_static_id || ' existiert nicht',
        p_display_location => apex_error.c_on_error_page);
  end;
  
  
  function validate_dep_emp_step1
    return boolean
  as
  begin
    return true;
  end validate_dep_emp_step1;
  
  
  procedure process_dep_emp_step2(
    p_seq_id in number,
    p_emp_id in varchar2,
    p_emp_first_name in varchar2,
    p_emp_last_name in varchar2,
    p_emp_email in varchar2,
    p_emp_phone_number in varchar2,
    p_emp_hire_date in varchar2,
    p_emp_job_id in varchar2,
    p_emp_salary in varchar2,
    p_emp_commission_pct in varchar2,
    p_emp_mgr_id in varchar2,
    p_emp_dep_id in varchar2)
  as
    l_row emp_ui_dep_emp_step2%rowtype;
  begin
    -- Daten typsicher umkopieren
    l_row.seq_id := to_number(p_seq_id);
    l_row.emp_id := to_number(p_emp_id);
    l_row.emp_first_name := p_emp_first_name;
    l_row.emp_last_name := p_emp_last_name;
    l_row.emp_email := upper(trim(p_emp_email));
    l_row.emp_phone_number := p_emp_phone_number;
    l_row.emp_hire_date := to_date(p_emp_hire_date, 'dd.mm.yyyy');
    l_row.emp_job_id := p_emp_job_id;
    l_row.emp_salary := to_number(p_emp_salary, '999999999D99');
    l_row.emp_commission_pct := to_number(p_emp_commission_pct, '99D99');
    l_row.emp_mgr_id := to_number(p_emp_mgr_id);
    l_row.emp_dep_id := p_emp_dep_id;
    
    case v('APEX$ROW_STATUS') 
      when 'I' then
        add_member(l_row);
      when 'U' then
        update_member(l_row);
      when 'D' then
        delete_member(l_row.seq_id);
      else
       null;
    end case; 
    
  end process_dep_emp_step2;
  
    
  procedure initialize_dep_emp_collection(
    p_dep_id in emp_ui_dep_emp_step2.emp_dep_id%type)
  as
    cursor dep_emp_cur is
      select rownum, e.*
        from hr_employees e
       where emp_dep_id = p_dep_id;
  begin
    apex_collection.create_or_truncate_collection(C_COLLECTION_NAME);
    for emp_row in dep_emp_cur loop
      add_member(emp_row);
    end loop;
  end initialize_dep_emp_collection;
    
end emp_ui;
/

prompt . EMP_REST
create or replace package emp_rest
  authid definer
as

  /**
    Procedure: export_emp_report
      Method exports data in the required format via an APEX WebService
      
    Parameters:
      p_format - Format for the export. Allowed values are CSV, HTML, PDF, XLSX, XML, PXML, JSON, PJSON
   */
  procedure export_emp_report(
    p_format in varchar2 default apex_data_export.c_format_html,
    p_export_type in varchar2 default apex_data_export.c_inline);
    
end emp_rest;
/


prompt . EMP_REST Body
create or replace package body emp_rest
as

  e_prerequisistes_not_met exception;
  pragma exception_init (e_prerequisistes_not_met, -20999);

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
    Procedure: check_export_type
    
    Parameter:
      p_format - Format to check
    
    Raises: e_prerequisistes_not_met if p_format does not contain an allowed export format
   */
  procedure check_export_type(
    p_export_type in varchar2)
  as
  begin
    if lower(p_export_type) not in ('inline', 'attachment') then
      htp.p('Ungültiger Exporttyp ' || p_export_type || ' übergeben. Es werden nur attachment und inline unterstützt');
      raise e_prerequisistes_not_met;
    end if;
  end check_export_type;
  
  
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
      

  procedure export_emp_report(
    p_format in varchar2 default apex_data_export.c_format_html,
    p_export_type in varchar2 default apex_data_export.c_inline)
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
         from emp_ui_emp_admin_main
        order by dep_id^';
    l_columns apex_data_export.t_columns;
    l_highlights apex_data_export.t_highlights;
    l_aggregates apex_data_export.t_aggregates;
  begin
    check_export_format(p_format);
    check_export_type(p_export_type);
    set_apex_session;
    
    l_context := apex_exec.open_query_context(
                   p_location => apex_exec.c_location_local_db,
                   p_sql_query => l_query);
                   
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
                  p_columns => l_columns,
                  p_highlights => l_highlights,
                  p_aggregates => l_aggregates);
                  
    apex_exec.close(l_context);
    apex_session.delete_session;
    
    apex_data_export.download(
      p_export => l_export,
      p_content_disposition => p_export_type,
      p_stop_apex_engine => false);
  exception
    when e_prerequisistes_not_met then
      null;      
  end export_emp_report;

end emp_rest;
/