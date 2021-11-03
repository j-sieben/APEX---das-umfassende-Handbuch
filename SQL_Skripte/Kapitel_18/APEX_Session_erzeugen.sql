create or replace procedure create_apex_session(
  p_application_id in apex_applications.application_id%type,
  p_apex_user in apex_workspace_activity_log.apex_user%type,
  p_page_id in apex_application_pages.page_id%type default 1)
  authid definer
as
  l_workspace_id apex_applications.workspace_id%type;
  l_param_name owa.vc_arr;
  l_param_val owa.vc_arr;
begin
  htp.init;
  l_param_name(1) := 'REQUEST_PROTOCOL';
  l_param_val(1) := 'HTTP';
  
  owa.init_cgi_env(
    num_params => 1,
    param_name => l_param_name,
    param_val =>l_param_val);
  
  select workspace_id
    into l_workspace_id
    from apex_applications
   where application_id = p_application_id;
  
  wwv_flow_api.set_security_group_id(l_workspace_id);
  
  apex_application.g_instance := 1;
  apex_application.g_flow_id := p_application_id;
  apex_application.g_flow_step_id := p_page_id;
  
  apex_custom_auth.post_login(
    p_uname => p_apex_user,
    p_session_id => apex_custom_auth.get_next_session_id,
    p_app_page => apex_application.g_flow_id || ':' || p_page_id);
end create_apex_session;
/
