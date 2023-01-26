prompt ******  Application/set_environment
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
    p_default_workspace_id=>11369389751207829);
end;
/
prompt  ******  WORKSPACE 11369389751207829
--
-- Workspace, User Group, User, and Team Development Export:
--   Date and Time:   13:08 Sonntag August 28, 2022
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
    p_security_group_id=>11369389751207829);
end;
/

----------------
-- W O R K S P A C E
-- Creating a workspace will not create database schemas or objects.
-- This API creates only the meta data for this APEX workspace
prompt .  Creating workspace BUCH_NO_CODE...
begin
  wwv_flow_fnd_user_api.create_company (
    p_id => 11369480404207837
   ,p_provisioning_company_id => 11369389751207829
   ,p_short_name => 'BUCH_NO_CODE'
   ,p_display_name => 'BUCH_NO_CODE'
   ,p_first_schema_provisioned => 'BUCH_NO_CODE'
   ,p_company_schemas => 'BUCH_NO_CODE'
   ,p_account_status => 'ASSIGNED'
   ,p_allow_plsql_editing => 'Y'
   ,p_allow_app_building_yn => 'Y'
   ,p_allow_packaged_app_ins_yn => 'Y'
   ,p_allow_sql_workshop_yn => 'Y'
   ,p_allow_websheet_dev_yn => 'Y'
   ,p_allow_team_development_yn => 'Y'
   ,p_allow_to_be_purged_yn => 'Y'
   ,p_allow_restful_services_yn => 'Y'
   ,p_source_identifier => 'BUCH_NO_'
   ,p_webservice_logging_yn => 'Y'
   ,p_path_prefix => 'BUCH_NO_CODE'
   ,p_files_version => 3
   ,p_env_banner_yn => 'N'
   ,p_env_banner_pos => 'LEFT'
  );
end;
/

----------------
-- G R O U P S
--
prompt ******  Creating Groups...
begin
  wwv_flow_fnd_user_api.create_user_group (
    p_id => 2400655054815034,
    p_GROUP_NAME => 'OAuth2 Client Developer',
    p_SECURITY_GROUP_ID => 10,
    p_GROUP_DESC => 'Users authorized to register OAuth2 Client Applications');
    
  wwv_flow_fnd_user_api.create_user_group (
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

prompt ******  Creating group grants...
----------------
-- U S E R S
-- User repository for use with APEX cookie-based authentication.
--
prompt  Creating Users...
begin
  wwv_flow_fnd_user_api.create_fnd_user (
    p_user_id                      => '11369248579207829',
    p_user_name                    => 'BUCH_ADMIN',
    p_first_name                   => 'Max',
    p_last_name                    => 'Mustermann',
    p_description                  => '',
    p_email_address                => 'max.mustermann@foo.de',
    p_web_password                 => '190E701FF6FCD315B2DC352DF6CA89B4032E33472B8BB0486D02502F062AD8868F732B610FEB23B13D1398AE5815A7570DF6F1604FE3936BEA4905F34B152D66',
    p_web_password_format          => '5;5;10000',
    p_group_ids                    => '',
    p_developer_privs              => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
    p_default_schema               => 'BUCH_NO_CODE',
    p_account_locked               => 'N',
    p_account_expiry               => to_date('202208061413','YYYYMMDDHH24MI'),
    p_failed_access_attempts       => 0,
    p_change_password_on_first_use => 'Y',
    p_first_password_use_occurred  => 'Y',
    p_allow_app_building_yn        => 'Y',
    p_allow_sql_workshop_yn        => 'Y',
    p_allow_websheet_dev_yn        => 'Y',
    p_allow_team_development_yn    => 'Y',
    p_allow_access_to_schemas      => '');
    
  wwv_flow_fnd_user_api.create_fnd_user (
    p_user_id                      => '12716102664621535',
    p_user_name                    => 'BUCH_ANWENDER',
    p_first_name                   => 'Jutta',
    p_last_name                    => 'Mayer',
    p_description                  => '',
    p_email_address                => 'jutta.mayer@foo.de',
    p_web_password                 => 'FC57CFE61301252432B61C42C49481D8FF36246CA7A8DBA0F0F12FD7698AC4B1E42F660E9FE49E148FC73B4B6AA98105B867C8DE9EF47E134555E66D8CC0F0E1',
    p_web_password_format          => '5;5;10000',
    p_group_ids                    => '',
    p_developer_privs              => '',
    p_default_schema               => 'BUCH_NO_CODE',
    p_account_locked               => 'N',
    p_account_expiry               => to_date('202203100000','YYYYMMDDHH24MI'),
    p_failed_access_attempts       => 0,
    p_change_password_on_first_use => 'N',
    p_first_password_use_occurred  => 'N',
    p_allow_app_building_yn        => 'N',
    p_allow_sql_workshop_yn        => 'N',
    p_allow_websheet_dev_yn        => 'N',
    p_allow_team_development_yn    => 'N',
    p_allow_access_to_schemas      => '');
    
  wwv_flow_fnd_user_api.create_fnd_user (
    p_user_id                      => '12715771260617018',
    p_user_name                    => 'BUCH_ENTWICKLER',
    p_first_name                   => 'Willi',
    p_last_name                    => 'Müller',
    p_description                  => '',
    p_email_address                => 'willi.mueller@foo.de',
    p_web_password                 => 'D4357D0A461E1B492EC4E079D918BD77CC530846D99CA6E32F90AE88B8C966C24C3DC4D28012049016C18AF4C4E5C350BA39633F6369D33FC47CBF88C15291FA',
    p_web_password_format          => '5;5;10000',
    p_group_ids                    => '2400469814815034:2400523155815034:2400655054815034:',
    p_developer_privs              => 'CREATE:EDIT:HELP:MONITOR:SQL:MONITOR:DATA_LOADER',
    p_default_schema               => 'BUCH_NO_CODE',
    p_account_locked               => 'N',
    p_account_expiry               => to_date('202203100000','YYYYMMDDHH24MI'),
    p_failed_access_attempts       => 0,
    p_change_password_on_first_use => 'N',
    p_first_password_use_occurred  => 'N',
    p_allow_app_building_yn        => 'Y',
    p_allow_sql_workshop_yn        => 'Y',
    p_allow_websheet_dev_yn        => 'Y',
    p_allow_team_development_yn    => 'Y',
    p_allow_access_to_schemas      => '');
end;
/

prompt ******  Check Compatibility...
begin
  -- This date identifies the minimum version required to import this file.
  wwv_flow_team_api.check_version(p_version_yyyy_mm_dd=>'2010.05.13');
  
  wwv_flow.g_import_in_progress := true; 
  wwv_flow.g_user := USER; 
  
  wwv_flow_api.import_end(
    p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
  commit;
end;
/
