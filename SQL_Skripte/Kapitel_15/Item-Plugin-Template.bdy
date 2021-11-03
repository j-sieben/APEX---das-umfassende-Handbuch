create or replace package body <plugin_pkg>
as 

  procedure render(
    p_item in apex_plugin.t_page_item,
    p_plugin in apex_plugin.t_plugin,
    p_param in apex_plugin.t_item_render_param,
    p_result in out nocopy apex_plugin.t_item_render_result)
  as
  begin
    null; -- TODO: Implementierung erforderlich
  end render;
    
  
  procedure reinit(
    p_item in apex_plugin.t_item,
    p_plugin in apex_plugin.t_plugin,
    p_param in apex_plugin.t_item_meta_data_param,
    p_result in out nocopy apex_plugin.t_item_meta_data_result)
  as
  begin
    null; -- TODO: Implementierung erforderlich
  end reinit;
    

  procedure refresh(
    p_item in apex_plugin.t_item,
    p_plugin in apex_plugin.t_plugin,
    p_param in apex_plugin.t_item_ajax_param,
    p_result in out nocopy apex_plugin.t_item_ajax_result)
  as
  begin
    null; -- TODO: Implementierung erforderlich
  end refresh;
    

  procedure validate(
    p_item   in apex_plugin.t_item,
    p_plugin in apex_plugin.t_plugin,
    p_param  in apex_plugin.t_item_validation_param,
    p_result in out nocopy apex_plugin.t_item_validation_result)
  as
  begin
    null; -- TODO: Implementierung erforderlich
  end validate;
  

  /** UEBERLADUNG FUER KOMPATIBILITAET ZU VERSION 5.0 **/
  function render (
    p_item in apex_plugin.t_page_item,
    p_plugin in apex_plugin.t_plugin,
    p_value in varchar2,
    p_is_readonly in boolean,
    p_is_printer_friendly in boolean)
    return apex_plugin.t_page_item_render_result
  as
    l_param apex_plugin.t_item_render_param;
    l_result apex_plugin.t_item_render_result;
  begin
    l_param.value := p_value;
    l_param.is_readonly := p_is_readonly;
    l_param.is_printer_friendly := p_is_printer_friendly;
    render(p_item, p_plugin, l_param, l_result);
    return l_result;
  end render;
    
  function refresh (
    p_item in apex_plugin.t_page_item,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_page_item_ajax_result
  as
    l_param apex_plugin.t_item_refresh_param;
    l_result apex_plugin.t_item_refresh_result;
  begin
    refresh(p_item, p_plugin, l_param, l_result);
    return l_result;
  end refresh;
    
    
  function validate (
    p_item in apex_plugin.t_page_item,
    p_plugin in apex_plugin.t_plugin,
    p_value  in varchar2)
    return apex_plugin.t_page_item_validation_result
  as
    l_param apex_plugin.t_item_validation_param;
    l_result apex_plugin.t_item_validation_result;
  begin
    l_param.value := p_value;
    validate(p_item, p_plugin, l_param, l_result);
    return l_result;
  end validate;

end <plugin_pkg>;