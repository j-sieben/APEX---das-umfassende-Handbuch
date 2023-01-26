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
    p_first_name                   => 'Max',
    p_last_name                    => 'Mustermann',
    p_description                  => '',
    p_email_address                => 'admin@mail.de',
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
