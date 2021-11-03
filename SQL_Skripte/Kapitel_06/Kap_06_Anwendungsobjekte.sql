set echo off
set termout off
set verify off
set serveroutput on

define APEX_USER=APEX_BUCH

alter session set current_schema = &APEX_USER.;

prompt Views anlegen
prompt .  EMP_UI_REPORT_MAIN

create or replace view emp_ui_report_main as
select emp.rowid "ROWID",
       emp_id,
       dep_id,
       emp_first_name,
       emp_last_name,
       emp_email, 
       emp_phone_number,
       job_name, 
       coalesce(dep_name, 'Zusatz: Ohne Abteilung') dep_name
  from dl_employees emp
  join dl_jobs job on emp_job_id = job_id
  left join dl_departments dep on emp_dep_id = dep_id;
  
  
prompt .  EMP_UI_COMPANY_HIERARCHY
create or replace view emp_ui_company_hierarchy as
with raw_data as(
        select to_char(reg_id) child_id, null parent_id, reg_name title, 'fa-globe' icon, reg_name tooltip, null link
          from dl_regions r
         union all
        select cou_id, to_char(cou_reg_id), cou_name, 'fa-flag-o', cou_name, null
          from dl_countries c
         union all
        select to_char(loc_id), loc_cou_id, loc_city, 'fa-bank', 
               loc_street || '<br>' || loc_postal_code || ' ' || loc_city || '<br>' || loc_state_province, null
          from dl_locations
         union all
        select to_char(dep_id), to_char(dep_loc_id), dep_name, 'fa-bullseye', dep_name, 
               q'~javascript:apex.item('P3_DEP_FILTER').setValue(~' || dep_id || ');'
          from dl_departments)
 select case when connect_by_isleaf = 1 then 0 when level = 1 then 1 else -1 end as status,
        level lvl, 
        title,
        icon,
        child_id value,
        tooltip,
        link
   from raw_data
  start with parent_id is null
connect by prior child_id = parent_id
  order siblings by title;
  
  
prompt .  EMP_UI_EMP_ADMIN_MAIN
create or replace view emp_ui_emp_admin_main as
select emp.rowid row_id,
       emp.emp_id,
       emp.emp_first_name,
       emp.emp_last_name,
       job.job_name,
       dep.dep_id,
       dep.dep_name
  from dl_employees emp
  join dl_departments dep on emp.emp_dep_id = dep.dep_id
  join dl_jobs job on emp.emp_job_id = job.job_id;
  
  
prompt .  EMP_UI_HOME
create or replace view emp_ui_home as
select count(distinct cou.cou_id) cou_amount,
       count(distinct loc.loc_id) loc_amount,
       count(distinct dep.dep_id) dep_amount,
       count(emp.emp_id) emp_amount
  from dl_countries cou
  left join dl_locations loc on cou.cou_id = loc.loc_cou_id
  left join dl_departments dep on loc.loc_id = dep.dep_loc_id
  left join dl_employees emp on dep.dep_id = emp.emp_dep_id;
  
 
prompt .  EMP_UI_HOME_CHART
create or replace view emp_ui_home_chart as
select count(emp.emp_id) emp_amount, cou.cou_id, cou.cou_name
  from dl_employees emp
  join dl_departments dep on emp.emp_dep_id = dep.dep_id
  join dl_locations loc on dep.dep_loc_id = loc.loc_id 
  join dl_countries cou on loc.loc_cou_id = cou.cou_id
 group by cou.cou_id, cou.cou_name;
 
prompt .  EMP_UI_HOME_COUNT
create or replace view emp_ui_home_count as
select cou_name, count (distinct l.loc_id) loc_amount, count(distinct d.dep_id) dep_amount, count(e.emp_id) emp_amount
  from dl_countries c
  join dl_locations l on c.cou_id = l.loc_cou_id
  join dl_departments d on l.loc_id = d.dep_loc_id
  join dl_employees e on d.dep_id = e.emp_dep_id
 group by cou_name
 order by emp_amount desc;
 

create or replace view emp_ui_emp_edit_history as
  with emps as(
       select joh_emp_id emp_id,
              joh_job_id emp_job_id,
              joh_dep_id emp_dep_id,
              joh_valid_from valid_from,
              joh_valid_til valid_til
         from dl_job_history joh
         join dl_jobs job
           on joh.joh_job_id = job.job_id
         join dl_departments dep
           on joh.joh_dep_id = dep.dep_id
       union all
       select emp_id, emp_job_id, emp_dep_id, emp_hire_date, null
         from dl_employees emp
         join dl_jobs job
           on emp.emp_job_id = job.job_id
         join dl_departments dep
           on emp.emp_dep_id = dep.dep_id)
select emp_id,
       job_name,
       dep_name,
       valid_from,
       valid_til
  from emps emp
  join dl_jobs job
    on emp.emp_job_id = job.job_id
  join dl_departments dep
    on emp.emp_dep_id = dep.dep_id;
 

prompt .  EMP_UI_LIST_MENU
create or replace view emp_ui_list_menu as
 select level level_value, 
        l.list_name,
        l.display_sequence,
        l.parent_entry_text,
        l.entry_text label_value,
        l.entry_target target_value,
        'NO' is_current,
        l.entry_image image_value,
        l.entry_image_attributes image_attr_value,
        l.entry_image_alt_attribute image_alt_value,
        l.entry_attribute_01 attribute_01,
        l.entry_attribute_02 attribute_02,
        l.entry_attribute_03 attribute_03,
        l.entry_attribute_04 attribute_04,
        l.entry_attribute_05 attribute_05,
        l.entry_attribute_06 attribute_06,
        l.entry_attribute_07 attribute_07,
        l.entry_attribute_08 attribute_08,
        l.entry_attribute_09 attribute_09,
        l.entry_attribute_10 attribute_10
   from apex_application_list_entries l
   left join apex_application_build_options o
     on l.application_id = o.application_id
    and l.build_option = o.build_option_name
  where l.application_id = (select v('APP_ID') from dual)
    and coalesce(o.build_option_status, 'Include') = 'Include'
  start with l.list_entry_parent_id is null
connect by prior l.list_entry_id = l.list_entry_parent_id;

 
prompt .  EMP_UI_LIST_PAGE_GROUP
create or replace view emp_ui_list_page_group as
   with params as (
        select v('APP_ID') application_id,
               v('APP_PAGE_ID') page_id
          from dual)
 select /*+ NO_MERGE (p) */ a.page_group
   from apex_application_pages a 
natural join params p;
 
  
prompt .  EMP_UI_LOV_JOBS
create or replace view emp_ui_lov_jobs as
select job_name d, job_id r
  from dl_jobs;
 
prompt .  EMP_UI_LOV_DEPARTMENTS
create or replace view emp_ui_lov_departments as
select dep.dep_name d, dep.dep_id r, 
       case when emp.emp_dep_id is not null then 1 else 0 end dep_has_employee
  from dl_departments dep
  left join (
       select dep_id emp_dep_id
         from dl_departments d
        where exists (
              select 1
                from dl_employees e
               where e.emp_dep_id = d.dep_id))emp
    on dep.dep_id = emp.emp_dep_id;

prompt .  EMP_UI_LOV_EMPLOYEES
create or replace view emp_ui_lov_employees as
select emp.emp_last_name || ', ' || emp.emp_first_name d, emp.emp_id r,
       case when mgr.emp_id is not null then 1 else 0 end emp_is_manager
  from dl_employees emp
  left join
       (select emp_id
          from dl_employees m
         where exists(
               select 1
                 from dl_employees e
                where e.emp_emp_id = m.emp_id)) mgr
    on emp.emp_id = mgr.emp_id;
    
    
create or replace package emp_ui_emp_edit_pkg
as
  function validate_email(
    p_emp_email in dl_employees.emp_email%type,
    p_emp_id in dl_employees.emp_id%type)
    return varchar2;

end emp_ui_emp_edit_pkg;
/


create or replace package body emp_ui_emp_edit_pkg
as
  function validate_email(
    p_emp_email in dl_employees.emp_email%type,
    p_emp_id in dl_employees.emp_id%type)
    return varchar2 
  as
    l_error_message varchar2(1000);
  begin
    if p_emp_email is null then
      l_error_message := 'Bitte geben Sie eine eindeutige Email-Adresse ein.';
    else
      select 'Diese Email-Adresse wird bereits verwendet. 
              Bitte geben Sie eine eindeutige Email-Adresse ein.'
        into l_error_message
        from DL_employees
       where emp_email = p_emp_email
         and emp_id != p_emp_id;
    end if;
    
    return l_error_message;
  exception
    when no_data_found then
      return null;
  end validate_email;

end emp_ui_emp_edit_pkg;
/


create or replace package emp_ui_pkg
as

  procedure show_help;
  
end emp_ui_pkg;
/

create or replace package body emp_ui_pkg
as

  c_yes constant varchar2(3 byte) := 'YES';
  c_no constant varchar2(3 byte) := 'NO';

  procedure show_help
  as
  begin
    apex_application.help (
      p_flow_id => v('APP_ID'),
      p_flow_step_id => v('REQUEST'),
      p_show_item_help => c_yes,
      p_show_regions => c_no,
      p_before_page_html => '<br/><br/><strong>Eingabefelder</strong><br/><dl>',
      p_after_page_html => '<dl><hr></br>',
      p_before_region_html => NULL,
      p_after_region_html => NULL,
      p_before_prompt_html => '<dt><strong>',
      p_after_prompt_html => '</strong></dt>',
      p_before_item_html => '<dd>',
      p_after_item_html => '</dd></br>'
    );
  end;

end;
/