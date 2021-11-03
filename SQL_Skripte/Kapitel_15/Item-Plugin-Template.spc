create or replace package <plugin_pkg>
as 

  /* Funktion zur Darstellung des Elements auf der Seite
     %param p_item Record, der naehere Informationen zum Item enthaelt
     %param p_plugin Record, der naehere Informationen zum Plugin enthaelt
     %param p_param Record mit dem Elementwert und weiteren Angaben zur Ausgabe
            des Seitenelements (Read-only, Printer-friendly)
     %param p_result Record mit Informationen, ob das Element navigable ist, also durch 
            den Benutzer ausgewaehlt werden kann.
     %usage Wird aufgerufen, wenn das Element auf der Seite angezeigt werden soll.
   */
  procedure render(
    p_item   in apex_plugin.t_page_item,
    p_plugin in apex_plugin.t_plugin,
    p_param  in apex_plugin.t_item_render_param,
    p_result in out nocopy apex_plugin.t_item_render_result);
    
  
  /* Prozedur zur Aktualisierung der Daten, falls das Element in einem interaktiven
     Grid verwendet wird.
     %param p_item Record, der naehere Informationen zum Item enthaelt
     %param p_plugin Record, der naehere Informationen zum Plugin enthaelt
     %param p_param Flag, das anzeigt, ob die Seite im druckfreundlichen
            Modus gezeigt werden soll
     %param p_result Record mit Informationen, ob das Element navigable ist, also durch 
            den Benutzer ausgewaehlt werden kann.
     %usage Wird aufgerufen, wenn ein Item-Plugin im Einsatz in interaktiven
            Grids neu initialisiert werden muss, nachdem es auf eine neue Zeile
            eingeblendet wurde
   */
  procedure reinit (
    p_item in apex_plugin.t_item,
    p_plugin in apex_plugin.t_plugin,
    p_param in apex_plugin.t_item_meta_data_param,
    p_result in out nocopy apex_plugin.t_item_meta_data_result);
    

  /* Prozedur zur Aktualisierung des Item_plugins
     %param p_item Record, der naehere Informationen zum Item enthaelt
     %param p_plugin Record, der naehere Informationen zum Plugin enthaelt
     %param p_param dummy, wird nicht verwendet
     %param p_result dummy, wird nicht verwendet.
     %usage Wird aufgerufen, wenn auf das Seitenelement event apexrefresh
            ausgeloest wird.
  */
  procedure refresh(
    p_item   in apex_plugin.t_item,
    p_plugin in apex_plugin.t_plugin,
    p_param  in apex_plugin.t_item_ajax_param,
    p_result in out nocopy apex_plugin.t_item_ajax_result);
    

  /* Prozedur zur Validierung von Benutzereingaben
     %param p_item Record, der naehere Informationen zum Item enthaelt
     %param p_plugin Record, der naehere Informationen zum Plugin enthaelt
     %param p_param Record, enthaelt derzeit nur den Wert des Elements
     %param p_result Record mit angaben zum Validierungsergebnis: Meldung, Ort der
            Darstellung des Fehlers, betroffenes Seitenelement.
     %usage Wird aufgerufen, wenn die Anwendungsseite validiert wird, um zu ermitteln,
            ob der eingefuegte Wert valide ist
  */
  procedure validate(
    p_item   in apex_plugin.t_item,
    p_plugin in apex_plugin.t_plugin,
    p_param  in apex_plugin.t_item_validation_param,
    p_result in out nocopy apex_plugin.t_item_validation_result);
  

  /** UEBERLADUNG FUER KOMPATIBILITAET ZU VERSION 5.0 **/
  function render (
    p_item in apex_plugin.t_page_item,
    p_plugin in apex_plugin.t_plugin,
    p_value in varchar2,
    p_is_readonly in boolean,
    p_is_printer_friendly in boolean)
    return apex_plugin.t_page_item_render_result;
    
    
  function refresh (
    p_item in apex_plugin.t_page_item,
    p_plugin in apex_plugin.t_plugin)
    return apex_plugin.t_page_item_ajax_result;
    
    
  function validate (
    p_item in apex_plugin.t_page_item,
    p_plugin in apex_plugin.t_plugin,
    p_value  in varchar2)
    return apex_plugin.t_page_item_validation_result;

end <plugin_pkg>;