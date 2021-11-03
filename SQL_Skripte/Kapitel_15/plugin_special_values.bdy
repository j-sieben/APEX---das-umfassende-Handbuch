create or replace package body plugin_special_values
as 

  -- Globaler Parameterrecord, um die uebergebenen Parameter
  -- zentral verfuegbar zu machen
  type param_rec is record(
    item_type varchar2(30),
    default_class varchar2(100),
    validate_immediate varchar2(10));

  g_params param_rec;

  c_true constant varchar2(5) := 'true';
  c_false constant varchar2(5) := 'false';
  c_error constant varchar2(10) := 'ERROR';
  c_ok constant varchar2(10) := 'OK';
  c_yes constant varchar2(5) := 'Y';

  /* Hilfsprozedur zur Uebernahme der Parameter in lokale Strukturen.
     %param p_item Record, der naehere Informationen zum Item enthaelt
     %usage Als Hilfsmethode ausgelagert, um schnell und konsistent die Parameter
            in eine lokale Datenstruktur zu uebernehmen
   */
  procedure read_attributes(
    p_item in apex_plugin.t_page_item)
  as
  begin
    -- Typ des Elements (z.B. IBAN, BIC), steuert die Validierung
    g_params.item_type := p_item.attribute_01;

    -- Flag, das anzeigt, ob das Element veim Verlassen dynamisch validiert werden soll
    -- oder erst nach dem Absenden
    if p_item.attribute_02 = c_yes then
      g_params.validate_immediate := c_true;
    else
      g_params.validate_immediate := c_false;
    end if;
  end read_attributes;
  
  
  /* Hilfsprozedur zur Ausgabe des Elements im READ_ONLY-Modus     
     %param p_item Record, der naehere Informationen zum Item enthaelt
     %param p_value Elementwert, kann ueber die generischen Attribute der Gruppen
            SOURCE bzw. DEFAULT gesetzt werden
     %param p_is_readonly Flag, das anzeigt, ob das Item in Nur-Lese-Darstellung
            gezeigt werden soll
     %param p_is_printer_friendly Flag, das anzeigt, ob die Seite im druckfreundlichen
            Modus gezeigt werden soll
     %usage Wird aufgerufen, wenn entweder IS_READ_ONLY oder IS_PRINTER_FRIENDLY
            gesetzt sind
   */
  procedure render_read_only(
    p_item in apex_plugin.t_page_item,
    p_param in apex_plugin.t_item_render_param)
  as
  begin

    -- Erzeugt HIDDEN-Element, dass den Wert des Elements aufnimmt
    apex_plugin_util.print_hidden_if_readonly(
      p_item_name => p_item.name,
      p_value => p_param.value,
      p_is_readonly => p_param.is_readonly,
      p_is_printer_friendly => p_param.is_printer_friendly);

    -- Erzeugt Standard-SPAN fuer ein Readonly-Feld
    apex_plugin_util.print_display_only(
      p_item_name => p_item.name,
      p_display_value => p_param.value,
      p_show_line_breaks => false,
      p_escape => true,
      p_attributes => p_item.element_attributes);

  end render_read_only;
  
  
  /* Hilfsfunktion zur Ausgabe des HTML-Elements auf der APEX_Seite
     %param p_item Record, der naehere Informationen zum Item enthaelt
     %param p_value Elementwert, kann ueber die generischen Attribute der Gruppen
            SOURCE bzw. DEFAULT gesetzt werden
     %usage Wird aufgerufen, um HTML-Code fuer das Plugin auf der Seite zu platzieren
   */
  procedure print_html_element(
    p_item in apex_plugin.t_page_item,
    p_value in varchar2)
  as
    -- HTML-Templates zur Darstellung des Items auf der Seite
    c_html_template constant varchar2(32767) := 
      q'~<input type="text" #STANDARD_ATTRIBUTES# value="#VALUE#" size="#SIZE#" maxlength="#MAX_LENGTH#" placeholder="#PLACEHOLDER#" #ATTRIBUTES# >~';
    l_standard_attributes varchar2(1000);
    l_item_value varchar2(100);
    l_item_name varchar2(100);
  begin

    -- Erzeugt ein name-Attribut in Abhaengigkeit von anderen Elementen auf der Seite
    l_item_name := apex_plugin.get_input_name_for_page_item(false);

    -- Erzeugt ein Set von Standardattributen fuer Eingabefelder (inkl. Screenreader etc.)
    l_standard_attributes := 
      apex_plugin_util.get_element_attributes(
        p_item => p_item,
        p_name => l_item_name,
        p_default_class => g_params.default_class,
        p_add_id => true,
        p_add_labelledby => false);

    -- Fals angefordert (Standard-Attribut Has Escape Output Attribute = TRUE), wird
    -- der Elementwert zunaechst von Steuerzeichen befreit
    l_item_value := 
      apex_plugin_util.escape(
        p_value => p_value,
        p_escape => p_item.escape_output);
    
    -- Ausgabe des HTML-Elements auf dem Bildschirm
    htp.p(utl_text.bulk_replace(c_html_template, char_table(
      '#STANDARD_ATTRIBUTES#', l_standard_attributes,
      '#VALUE#', l_item_value,
      '#SIZE#', p_item.element_width,
      '#MAX_LENGTH#', p_item.element_max_length,
      '#PLACEHOLDER#', p_item.placeholder,
      '#ATTRIBUTES#', p_item.element_attributes)));

  end print_html_element;
  
  
  /* Hilfsprozedur zur Erzeugung einer JavaScript-Instanz fuer das Eingabeelement.
     %param p_item Record, der naehere Informationen zum Item enthaelt
     %usage Wird aufgerufen, um eine JavaScript-Instanz zu erzeugen, die Standard-
            ITEM-Funktionalitaet enthaelt (SET/GET_VALUE etc.)
   */
  procedure add_javascript_code(
    p_item in apex_plugin.t_page_item)
  as
    l_ajax_identifier varchar2(100);
    c_javascript_template constant varchar2(1000) := 
      q'~apex.widget.specialValues("##ID#", {"ajaxIdentifier":"#AJAX_ID#","validateOnChange":#VALIDATE_IMMEDIATE#});~';
  begin
    l_ajax_identifier := apex_plugin.get_ajax_identifier;

    -- JavaScript-Instanz auf der Seite platzieren
    apex_javascript.add_onload_code(
      p_code => utl_text.bulk_replace(c_javascript_template, char_table(
        '#ID#', p_item.name,
        '#AJAX_ID#', l_ajax_identifier,
        '#VALIDATE_IMMEDIATE#', g_params.validate_immediate)));
  end add_javascript_code;

  procedure render(
    p_item in apex_plugin.t_page_item,
    p_plugin in apex_plugin.t_plugin,
    p_param in apex_plugin.t_item_render_param,
    p_result in out nocopy apex_plugin.t_item_render_result)
  as
  begin

    -- Falls im DEBUG-Modus, soll auch das Plugin Meldungen emittieren koennen
    if apex_application.g_debug then
      apex_plugin_util.debug_page_item(
        p_plugin => p_plugin,
        p_page_item => p_item,
        p_value => p_param.value,
        p_is_readonly => p_param.is_readonly,
        p_is_printer_friendly => p_param.is_printer_friendly);
    end if;
        
    -- Auswertung der Flags IS_READONLY/IS_PRINTER_FRIENDLY
    if p_param.is_readonly or p_param.is_printer_friendly then
      render_read_only(p_item, p_param);
    else
      -- Element soll bearbeitet werden koennen
      read_attributes(p_item);      
      print_html_element(p_item, p_param.value);
      add_javascript_code(p_item);
    end if;
  end render;
    
  
  procedure reinit(
    p_item in apex_plugin.t_item,
    p_plugin in apex_plugin.t_plugin,
    p_param in apex_plugin.t_item_meta_data_param,
    p_result in out nocopy apex_plugin.t_item_meta_data_result)
  as
  begin
    null; -- STUB, wird hier nicht gebraucht
  end reinit;
    

  procedure refresh(
    p_item in apex_plugin.t_item,
    p_plugin in apex_plugin.t_plugin,
    p_param in apex_plugin.t_item_ajax_param,
    p_result in out nocopy apex_plugin.t_item_ajax_result)
  as
    c_json_template constant varchar2(200) := 
      q'^{"status":"#STATUS#","value":"#VALUE#","err":{"type":"error","location":["page","inline"],"pageItem":"#NAME#","message":"#MESSAGE#"}}^';
    
    l_validation_param apex_plugin.t_item_validation_param;
    l_validation_result apex_plugin.t_page_item_validation_result;
    l_status varchar2(5);
  begin
    
    -- Uebergebene Parameter in lokale Struktur kopieren
    read_attributes(p_item);
    l_validation_param.value := v(p_item.name);
    
    validate(p_item, p_plugin, l_validation_param, l_validation_result);
    
    if l_validation_result.message is not null then
      l_status := c_error;
    else
      l_status := c_ok;
    end if;
    
    -- Validierungsergebnis als JSON-String zurückgeben
    htp.p(utl_text.bulk_replace(c_json_template, char_table(
      '#STATUS#', l_status,
      '#MESSAGE#', l_validation_result.message,
      '#NAME#', p_item.name,
      '#VALUE#', v(p_item.name))));
  end refresh;
    

  procedure validate(
    p_item   in apex_plugin.t_item,
    p_plugin in apex_plugin.t_plugin,
    p_param  in apex_plugin.t_item_validation_param,
    p_result in out nocopy apex_plugin.t_item_validation_result)
  as
    -- Liste der Elementtypen. Fuer jeden neuen Eventtyp hier einen Eintrag machen,
    -- in der CASE-Anweisung eine Validierungsfunktion definieren und
    -- Im Plugin-Attribut einen Eintrag in der select-Liste erstellen
    c_iban constant varchar2(10) := 'IBAN';
    c_bic constant varchar2(10) := 'BIC';
    
    l_value varchar2(200);
  begin

    -- Uebergebene Parameter in lokale Struktur kopieren
    read_attributes(p_item);
    l_value := p_param.value;
    
    -- Validierungen durchfuehren
    case g_params.item_type
    when c_iban then
      bl_validation.validate_iban(l_value, p_result.message);
    when c_bic then
      bl_validation.validate_bic(l_value, p_result.message);
    else
      p_result.message := 'Unbekannter Elementtyp'; -- TODO: Fehlermeldung in Fehlerpackage auslagern
    end case;
   
    -- Neu formatierter Elementwert in Sessionstatus speichern
    apex_util.set_session_state(p_item.name, l_value);
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
    l_param apex_plugin.t_item_ajax_param;
    l_result apex_plugin.t_item_ajax_result;
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

end plugin_special_values;
/