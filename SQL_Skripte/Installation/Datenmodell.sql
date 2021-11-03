prompt *** APEX Datenmodell installieren

prompt
prompt Benutzer &APEX_USER. anlegen
declare
  user_exists exception;
  pragma exception_init(user_exists, -1921);
begin
  execute immediate 'create user &APEX_USER. identified by &APEX_PWD. default tablespace &APEX_WS.';
  execute immediate 'alter user &APEX_USER. quota unlimited on &APEX_WS.';
  execute immediate 'grant connect, resource to &APEX_USER.';
  execute immediate 'grant create view, create materialized view, create synonym, create sequence, create table, create trigger to &APEX_USER.';
exception
  when user_exists then
    dbms_output.put_line('Benutzer &APEX_USER. existiert bereits.');
  when others then
    dbms_output.put_line('*** FEHLER: Installation abbrechen');
    raise;
end;
/

prompt Testen, ob Benutzer HR existiert
declare
  l_user varchar2(30 byte);
begin
  select username
    into l_user
    from all_users
   where username = 'HR';
exception
  when no_data_found then 
    dbms_output.put_line('*** FEHLER: Benutzer HR ist nicht vorhanden. Installation abbrechen');
    raise;
end;
/

prompt Zusaetliche Tabellen in HR anlegen
prompt Tabelle FILE_TYPES
declare
  l_table_name varchar2(30 byte);
begin
  select table_name
    into l_table_name
    from all_tables
   where owner = 'HR'
     and table_name = 'FILE_TYPES';
    
  dbms_output.put_line('Tabelle FILE_TYPES existiert bereits');
exception
  when no_data_found then 
    execute immediate q'^
  create table hr.file_types(
    file_type_id varchar2(20 char),
    description varchar2(50 char),
    active char(1 byte) default 'Y',
    constraint pk_file_types primary key(file_type_id)
  ) organization index^';
    
    dbms_output.put_line('Tabelle HR.FILE_TYPES erstellt');
  when others then
    dbms_output.put_line('*** FEHLER: Installation abbrechen');
    raise;
end;
/

merge into hr.file_types f
using (select 'PHOTO' file_type_id, 'Fotografie' description
         from dual
       union all
       select 'FILE', 'Datei' from dual) v
   on (f.file_type_id = v.file_type_id)
 when not matched then insert(file_type_id, description)
      values(v.file_type_id, v.description);
      
commit;

prompt Tabelle EMPLOYEE_FILES
declare
  l_table_name varchar2(30 byte);
begin
  select table_name
    into l_table_name
    from all_tables
   where owner = 'HR'
     and table_name = 'EMPLOYEE_FILES';
    
  dbms_output.put_line('Tabelle EMPLOYEE_FILES existiert bereits');
exception
  when no_data_found then 
    execute immediate q'^
  create table hr.employee_files(
    file_id number,
    employee_id number,
    file_type_id varchar2(20 char),
    description varchar2(50 char),
    file_name varchar2(200 char),
    mime_type varchar2(50 char),
    encoding varchar2(20 char),
    file_length number,
    file_content blob,
    last_updated timestamp,
    constraint pk_files primary key(file_id),
    constraint fk_file_emp_id foreign key(employee_id)
      references hr.employees(employee_id),
    constraint fk_file_type_id foreign key(file_type_id)
      references hr.file_types(file_type_id)
  ) organization index^';
    
    dbms_output.put_line('Tabelle HR.MPLOYEE_FILES erstellt');
  when others then
    dbms_output.put_line('*** FEHLER: Installation abbrechen');
    raise;
end;
/


prompt Sequenz FILE_SEQ
declare
  l_sequence_name varchar2(30 byte);
begin
  select sequence_name
    into l_sequence_name
    from all_sequences
   where sequence_owner = 'HR'
     and sequence_name = 'FILE_SEQ';
    
  dbms_output.put_line('Sequenz FILE_SEQ existiert bereits');
exception
  when no_data_found then 
    execute immediate q'^create sequence hr.file_seq^';
    
    dbms_output.put_line('Sequenz HR.FILE_SEQ erstellt');
  when others then
    dbms_output.put_line('*** FEHLER: Installation abbrechen');
    raise;
end;
/


prompt Benutzerrechte an Tabellen des Benutzers HR an &APEX_USER. vergeben
declare
  cursor table_cur is
    select table_name
      from all_tables
     where owner = 'HR';
begin
  for tbl in table_cur loop
    execute immediate 'grant select, insert, update, delete, references on hr.' || tbl.table_name || ' to &APEX_USER.';
    dbms_output.put_line('.  Rechte an Tabelle ' || tbl.table_name || ' eingerichtet');
  end loop;
end;
/

grant select on hr.employees_seq to &APEX_USER.;
grant select on hr.file_seq to &APEX_USER.;
grant select on hr.departments_seq to &APEX_USER.;
grant select on hr.locations_seq to &APEX_USER.;

alter session set current_schema = &APEX_USER.;

prompt Synonyme auf Sequenzen erstellen
create synonym employees_seq for hr.employees_seq;
create synonym files_seq for hr.files_seq;
create synonym departments_seq for hr.departments_seq;
create synonym locations_seq for hr.locations_seq;

prompt Daten aus Benutzer HR per Basisviews verfuegbar machen

prompt .  View DL_COUNTRIES
create or replace view dl_countries as
select country_id cou_id,
       country_name cou_name,
       region_id cou_reg_id
  from hr.countries;

prompt .  View DL_DEPARTMENTS
create or replace view dl_departments as
select department_id dep_id,
       department_name dep_name,
       manager_id dep_emp_id,
       location_id dep_loc_id
  from hr.departments;
  
prompt .  View DL_EMPLOYEES
create or replace view dl_employees as
select employee_id emp_id,
       first_name emp_first_name,
       last_name emp_last_name,
       email emp_email,
       phone_number emp_phone_number,
       hire_date emp_hire_date,
       job_id emp_job_id,
       salary emp_salary,
       commission_pct emp_commission_pct,
       manager_id emp_emp_id,
       department_id emp_dep_id
  from hr.employees;
  
  
prompt .  View DL_JOB_HISTORY
create or replace view dl_job_history as
select employee_id joh_emp_id,
       start_date joh_valid_from,
       end_date joh_valid_til,
       job_id joh_job_id,
       department_id joh_dep_id
  from hr.job_history;
  
prompt .  View DL_JOBS
create or replace view dl_jobs as
select job_id,
       job_title job_name,
       min_salary job_min_salary,
       max_salary job_max_salary
  from hr.jobs;
  
prompt .  View DL_LOCATIONS
create or replace view dl_locations as
select location_id loc_id,
       street_address loc_street,
       postal_code loc_postal_code,
       city loc_city,
       state_province loc_state_province,
       country_id loc_cou_id
  from hr.locations;
  
prompt .  View DL_REGIONS
create or replace view dl_regions as
select region_id reg_id,
       region_name reg_name
  from hr.regions;
  
  
prompt .  View DL_FILE_TYPES
create or replace view dl_file_types as
select file_type_id fty_id,
       description fty_description,
       active fty_active
  from hr.file_types;
  
prompt .  View DL_EMPLOYEE_FILES
create or replace view dl_employee_files as
select file_id efi_id,
       employee_id efi_emp_id,
       file_type_id efi_fty_id,
       description efi_description,
       file_name efi_name,
       mime_type efi_mime_type,
       encoding efi_encoding,
       file_length efi_length,
       file_content efi_content,
       last_updated efi_last_updated
  from hr.employee_files;