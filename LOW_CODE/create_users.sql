define LC_DATA = BUCH_LC_DATA
define LC_APEX = BUCH_LC_APEX
define LC_REST = BUCH_LC_REST
define LC_UTILS = BUCH_LC_UTILS
define PWD = "Start!1234"
define TABLESPACE = USERS

prompt * Extend role RESOURCE with CREATE VIEW, MATERIALIZED VIEW and SYNONYM
grant create view, create materialized view, create synonym to resource;

prompt * Create users
prompt . User &LC_DATA.

create user &LC_DATA. identified by &PWD. default tablespace &TABLESPACE. quota unlimited on &TABLESPACE.;

grant connect, resource to &LC_DATA.;


prompt . &LC_APEX.
create user &LC_APEX. identified by &PWD.  default tablespace &TABLESPACE. quota unlimited on &TABLESPACE.;

grant connect, resource to &LC_APEX.;


prompt * Get installed apex user
col apex_user new_val APEX_USER format a30

select max(username) apex_user
  from all_users
 where username like 'APEX\_______' escape '\';

prompt * Grant ACL permission to github to &APEX_USER.
begin
  dbms_network_acl_admin.append_host_ace( 
    host => 'raw.githubusercontent.com', 
    lower_port => 80,
    upper_port => 80,
    ace => xs$ace_type(
             privilege_list => xs$name_list('http'), 
             principal_name => '&APEX_USER.',
             principal_type => xs_acl.ptype_db));
end; 
/

prompt . User &LC_REST.
create user &LC_REST. identified by &PWD. default tablespace &TABLESPACE. quota unlimited on &TABLESPACE.;

grant connect, resource to &LC_REST.;

prompt . User &LC_UTILS.

create user &LC_UTILS. identified by &PWD. default tablespace &TABLESPACE. quota unlimited on &TABLESPACE.;

grant resource, connect, create procedure, alter session to &LC_UTILS.;

prompt * Install user objects

prompt . APEX Workspace
alter session set current_schema=&LC_APEX.;
@create_workspace.sql

prompt . User &LC_UTILS.
alter session set current_schema=&LC_UTILS.;
@install_buch_lc_utils.sql

prompt . User &LC_DATA.
alter session set current_schema=&LC_DATA.;
@install_buch_lc_data.sql

prompt . User &LC_APEX.
alter session set current_schema=&LC_APEX.;
@install_buch_lc_apex.sql

prompt . User &LC_REST.
alter session set current_schema=&LC_REST.;
@install_buch_lc_rest.sql