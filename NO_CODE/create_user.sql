create user buch_no_code identified by "start!1234" default tablespace users;

grant connect, resource to buch_no_code;

alter user buch_no_code quota unlimited on users;

grant create view, create materialized view, create synonym to resource;


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

alter session set current_schema=BUCH_NO_CODE;
@install.sql
