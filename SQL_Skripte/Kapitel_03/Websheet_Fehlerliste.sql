set define off
set verify off
set serveroutput on size 1000000
set feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
begin wwv_flow.g_import_in_progress := true; end;
/
 
 
--application/set_environment
prompt  WEBSHEET APPLICATION 111 - Fehlerliste
--
-- Websheet Application Export:
--   Application:     111
--   Name:            Fehlerliste
--   Date and Time:   12:43 Dienstag Dezember 27, 2016
--   Exported By:     BUCH_ADMIN
--   Export Type:     Websheet Application Export
--   Version:         5.1.0.00.45
--   Instance ID:     218209005588664
--   Websheet Schema: APEX_BUCH
--
-- Import:
--   Using App Builder
--   or
--   Using SQL*Plus as the Oracle user Websheet schema, APEX_BUCH
 
-- Application Statistics:
--   Pages:                  1
--   Data Grids:             1
--   Reports:                0
 
 
--
-- ORACLE
--
-- Application Express (APEX)
--
prompt  Set Credentials...
 
begin
 
  -- Assumes you are running the script connected to SQL*Plus as the Websheet schema, APEX_BUCH.
  wwv_flow_api.set_security_group_id(p_security_group_id=>nvl(wwv_flow_application_install.get_workspace_id,6411089253137985));
 
end;
/

begin wwv_flow.g_import_in_progress := true; end;
/
begin

select value into wwv_flow_api.g_nls_numeric_chars from nls_session_parameters where parameter='NLS_NUMERIC_CHARACTERS';

end;

/
begin execute immediate 'alter session set nls_numeric_characters=''.,''';

end;

/
begin wwv_flow.g_browser_language := 'de'; end;
/
prompt  Check Compatibility...
 
begin
 
-- This date identifies the minimum version required to import this file.
wwv_flow_api.set_version(p_version_yyyy_mm_dd=>'2016.08.24');
 
end;
/

prompt  Set Application ID...
 
begin
 
   -- SET APPLICATION ID
   wwv_flow.g_ws_app_id := nvl(wwv_flow_application_install.get_application_id,111);
   wwv_flow_api.g_id_offset := nvl(wwv_flow_application_install.get_offset,0);
 
end;
/

prompt  ...Remove Websheet Application
--application/delete_application
 
begin
 
-- remove internal metadata
wwv_flow_api.remove_ws_app(nvl(wwv_flow_application_install.get_application_id,111));
-- remove websheet metadata
wwv_flow_ws_import_api.remove_ws_components(nvl(wwv_flow_application_install.get_application_id,111));
 
end;
/

prompt  ...Create Websheet Application
--application/create_ws_app
begin
    wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
 
end;
/

begin
wwv_flow_api.create_ws_app(
  p_id    => nvl(wwv_flow_application_install.get_application_id,111),
  p_name  => 'Fehlerliste',
  p_owner => nvl(wwv_flow_application_install.get_schema,'APEX_BUCH'),
  p_description => '',
  p_status => 'AVAILABLE',
  p_language => 'de',
  p_territory => 'AMERICA',
  p_home_page_id => 21467073131267679+wwv_flow_api.g_id_offset,
  p_page_style => '0',
  p_auth_id => 21467170938267679+wwv_flow_api.g_id_offset,
  p_acl_type => 'CUSTOM',
  p_login_url => '',
  p_logout_url => '',
  p_allow_sql_yn => 'N',
  p_show_reset_passwd_yn => 'Y',
  p_allow_public_access_yn => 'Y',
  p_logo_type => 'TEXT',
  p_logo_text => 'Fehlerliste',
  p_varchar2_table => wwv_flow_api.g_varchar2_table,
  p_email_from => '');
----------------
 
end;
/

----------------
--package app map
--
prompt  ...Create Access Control List
begin
wwv_flow_ws_import_api.create_acl (
  p_id => 48283828856704351547713393550019459356+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_username => 'BUCH_WS_ENTWICKLER',
  p_priv => 'C'
  );
 
end;
/

begin
wwv_flow_ws_import_api.create_acl (
  p_id => 161055313085340085841644191136625694205+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_username => 'BUCH_WS_ADMIN',
  p_priv => 'A'
  );
 
end;
/

begin
wwv_flow_ws_import_api.create_acl (
  p_id => 295200978337543531269653821899903531604+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_username => 'BUCH_WS_READER',
  p_priv => 'R'
  );
 
end;
/

prompt  ...Create Application Authentication Set Up
declare
  sf varchar2(32767) := null;
  vf varchar2(32767) := null;
  pre_ap varchar2(32767) := null;
  af varchar2(32767) := null;
  post_ap varchar2(32767) := null;
begin
af:=af||'-BUILTIN-';

wwv_flow_api.create_ws_auth_setup(
  p_id => 21467170938267679+wwv_flow_api.g_id_offset,
  p_websheet_application_id => wwv_flow.g_ws_app_id,
  p_name => 'Apex Authentication',
  p_invalid_session_url => 'f?p=4900:101:&SESSION.::NO::WS_APP_ID,P900_ID:&WS_APP_ID.,&P900_ID.&p_lang=&APP_SESSION_LANG.&p_territory=&APP_SESSION_TERRITORY.',
  p_auth_function => af,
  p_use_secure_cookie_yn => 'N',
  p_logout_url => 'ws?p='||wwv_flow.g_ws_app_id||':home'
  );
 
end;
/

prompt  ...Create Data Grid
declare
  q varchar2(32767) := null;
begin
q := null;
wwv_flow_api.create_ws_worksheet (
  p_id => 21467921154330789+wwv_flow_api.g_id_offset,
  p_page_id => 2,
  p_region_id => null,
  p_name => 'Fehlerliste',
  p_max_row_count => '1000000',
  p_max_row_count_message => 'Die maximale Anzahl der Zeilen für diesen Bericht ist #MAX_ROW_COUNT#. Wenden Sie einen Filter an, um die Anzahl der Datensätze in der Abfrage zu reduzieren.',
  p_no_data_found_message => 'Keine Daten gefunden.',
  p_sql_query => q,
  p_status => 'AVAILABLE_FOR_OWNER',
  p_allow_report_saving => 'Y',
  p_allow_report_categories => 'Y',
  p_pagination_type => 'ROWS_X_TO_Y_OF_Z',
  p_pagination_display_pos => 'BOTTOM_RIGHT',
  p_show_finder_drop_down => 'Y',
  p_show_display_row_count => 'N',
  p_show_search_bar => 'Y',
  p_show_search_textbox => 'Y',
  p_show_actions_menu => 'Y',
  p_report_list_mode => 'TABS',
  p_fixed_header => 'NONE',
  p_show_select_columns => 'Y',
  p_show_filter => 'Y',
  p_show_sort => 'Y',
  p_show_control_break => 'Y',
  p_show_highlight => 'Y',
  p_show_computation => 'Y',
  p_show_aggregate => 'Y',
  p_show_chart => 'Y',
  p_show_group_by => 'Y',
  p_show_pivot => 'Y',
  p_show_calendar => 'Y',
  p_show_flashback => 'Y',
  p_show_reset => 'Y',
  p_show_download => 'Y',
  p_show_help => 'Y',
  p_show_detail_link => 'Y',
  p_download_formats => 'CSV:HTML:EMAIL',
  p_allow_exclude_null_values => 'Y',
  p_allow_hide_extra_columns => 'Y',
  p_icon_view_enabled_yn => 'N',
  p_icon_view_use_custom=>'N',
  p_detail_view_enabled_yn => 'N',
  p_show_notify => 'N',
  p_allow_save_rpt_public => 'N',
  p_show_rows_per_page => 'Y',
  p_internal_uid => 21467921154330789
  );
end;
/
begin
wwv_flow_api.create_ws_data_grid (
    p_id => 21468093859330789+wwv_flow_api.g_id_offset,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_worksheet_id => 21467921154330789+wwv_flow_api.g_id_offset,
    p_ws_report_owner => '',
    p_is_template => '',
    p_status => 'PRIVATE',
    p_websheet_type => 'DATA',
    p_websheet_name => 'Fehlerliste',
    p_websheet_alias => 'FEHLERLISTE',
    p_websheet_owner => 'BUCH_ADMIN',
    p_geo_resp_sep => ''
  );
end;
/
begin
wwv_flow_api.create_ws_lov (
  p_id => 21468936456345862+wwv_flow_api.g_id_offset,
  p_worksheet_id => 21467921154330789+wwv_flow_api.g_id_offset,
  p_websheet_id => 21468093859330789+wwv_flow_api.g_id_offset,
  p_name => 'Statusliste'
  );
end;
/
begin
wwv_flow_api.create_ws_lov_entries (
  p_id => 21469050881345864+wwv_flow_api.g_id_offset,
  p_worksheet_id => 21467921154330789+wwv_flow_api.g_id_offset,
  p_websheet_id => 21468093859330789+wwv_flow_api.g_id_offset,
  p_lov_id => 21468936456345862+wwv_flow_api.g_id_offset,
  p_display_sequence => 1,
  p_entry_text => 'OFFEN'
  );
end;
/
begin
wwv_flow_api.create_ws_lov_entries (
  p_id => 21469109603345864+wwv_flow_api.g_id_offset,
  p_worksheet_id => 21467921154330789+wwv_flow_api.g_id_offset,
  p_websheet_id => 21468093859330789+wwv_flow_api.g_id_offset,
  p_lov_id => 21468936456345862+wwv_flow_api.g_id_offset,
  p_display_sequence => 2,
  p_entry_text => 'IN_BEARBEITUNG'
  );
end;
/
begin
wwv_flow_api.create_ws_lov_entries (
  p_id => 21469216965345864+wwv_flow_api.g_id_offset,
  p_worksheet_id => 21467921154330789+wwv_flow_api.g_id_offset,
  p_websheet_id => 21468093859330789+wwv_flow_api.g_id_offset,
  p_lov_id => 21468936456345862+wwv_flow_api.g_id_offset,
  p_display_sequence => 3,
  p_entry_text => 'ERLEDIGT'
  );
end;
/
begin
wwv_flow_api.create_ws_lov_entries (
  p_id => 21469330408345864+wwv_flow_api.g_id_offset,
  p_worksheet_id => 21467921154330789+wwv_flow_api.g_id_offset,
  p_websheet_id => 21468093859330789+wwv_flow_api.g_id_offset,
  p_lov_id => 21468936456345862+wwv_flow_api.g_id_offset,
  p_display_sequence => 4,
  p_entry_text => 'GEPRUEFT'
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 21468132731330790+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 21467921154330789+wwv_flow_api.g_id_offset,
  p_websheet_id => 21468093859330789+wwv_flow_api.g_id_offset,
  p_db_column_name => 'N001',
  p_display_order => 10,
  p_data_grid_form_seq => 1,
  p_column_identifier => 'A',
  p_column_label => 'Fehlernummer',
  p_report_label => 'Fehlernummer',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'NUMBER',
  p_tz_dependent => '',
  p_display_as => 'TEXT',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'CENTER',
  p_column_alignment => 'RIGHT',
  p_max_length => 40,
  p_display_width => 15,
  p_display_height => null,
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_column_comment => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 21468266300330790+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 21467921154330789+wwv_flow_api.g_id_offset,
  p_websheet_id => 21468093859330789+wwv_flow_api.g_id_offset,
  p_db_column_name => 'C001',
  p_display_order => 20,
  p_data_grid_form_seq => 2,
  p_column_identifier => 'B',
  p_column_label => 'Titel',
  p_report_label => 'Titel',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'STRING',
  p_tz_dependent => '',
  p_display_as => 'TEXT',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'CENTER',
  p_column_alignment => 'LEFT',
  p_max_length => 4000,
  p_display_width => 30,
  p_display_height => null,
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_column_comment => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 21468342149330790+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 21467921154330789+wwv_flow_api.g_id_offset,
  p_websheet_id => 21468093859330789+wwv_flow_api.g_id_offset,
  p_db_column_name => 'C002',
  p_display_order => 30,
  p_data_grid_form_seq => 3,
  p_column_identifier => 'C',
  p_column_label => 'Beschreibung',
  p_report_label => 'Beschreibung',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'STRING',
  p_tz_dependent => '',
  p_display_as => 'TEXTAREA',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'CENTER',
  p_column_alignment => 'LEFT',
  p_max_length => 4000,
  p_display_width => 30,
  p_display_height => 5,
  p_allow_null => 'Y',
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_column_comment => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 21468459849330792+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 21467921154330789+wwv_flow_api.g_id_offset,
  p_websheet_id => 21468093859330789+wwv_flow_api.g_id_offset,
  p_db_column_name => 'C003',
  p_display_order => 40,
  p_data_grid_form_seq => 4,
  p_column_identifier => 'D',
  p_column_label => 'Status',
  p_report_label => 'Status',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'STRING',
  p_tz_dependent => '',
  p_display_as => 'SELECTLIST',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'CENTER',
  p_column_alignment => 'LEFT',
  p_max_length => 4000,
  p_display_width => 30,
  p_display_height => null,
  p_allow_null => 'Y',
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_lov_id => 21468936456345862+wwv_flow_api.g_id_offset,
  p_column_comment => ''
  );
end;
/
declare
    rc1 varchar2(32767) := null;
begin
rc1:=rc1||'N001:C001:C002:C003:scnt:lcnt:tags:acnt:';

wwv_flow_api.create_ws_rpt(
  p_id => 21468528673330803+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 21467921154330789+wwv_flow_api.g_id_offset,
  p_websheet_id  => 21468093859330789+wwv_flow_api.g_id_offset,
  p_session_id  => null,
  p_base_report_id  => null+wwv_flow_api.g_id_offset,
  p_application_user => 'APXWS_DEFAULT',
  p_report_seq => 10,
  p_report_alias => '214686',
  p_status => 'PUBLIC',
  p_is_default => 'Y',
  p_display_rows => 50,
  p_report_columns => rc1,
  p_flashback_enabled => 'N',
  p_calendar_display_column => ''
  );
end;
/
declare
    rc1 varchar2(32767) := null;
begin
rc1:=rc1||'C003:N001:';

wwv_flow_api.create_ws_rpt(
  p_id => 21470211919442362+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 21467921154330789+wwv_flow_api.g_id_offset,
  p_websheet_id  => 21468093859330789+wwv_flow_api.g_id_offset,
  p_session_id  => null,
  p_base_report_id  => null+wwv_flow_api.g_id_offset,
  p_application_user => 'APXWS_ALTERNATIVE',
  p_name => 'Anzahl nach Status',
  p_report_seq => 10,
  p_report_alias => '214703',
  p_status => 'PUBLIC',
  p_is_default => 'Y',
  p_display_rows => 50,
  p_report_columns => rc1,
  p_flashback_enabled => 'N',
  p_calendar_display_column => ''
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'EIN FEHLER IM DIALOG'||chr(10)||
'DIESER FEHLER TRITT VEREINZELT AUF'||chr(10)||
'OFFEN'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 124136011877362111358501747764595388997+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 21468093859330789+wwv_flow_api.g_id_offset,
  p_unique_value => 'AADW',
  p_owner => 'BUCH_ADMIN',
  p_load_order => 241904200527664918764731328758722186235,
  p_c001 => 'Ein Fehler im Dialog',
  p_c002 => 'Dieser Fehler tritt vereinzelt auf',
  p_c003 => 'OFFEN',
  p_n001 => 1,
  p_search_clob => sc
  );
end;
/
prompt  ...Create Report
 
--application/pages/page_21467073131267679
prompt  ...PAGE 21467073131267679: Home
--
begin
wwv_flow_api.create_ws_page (
    p_id => 21467073131267679+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => null+wwv_flow_api.g_id_offset,
    p_name => 'Home',
    p_upper_name => 'HOME',
    p_page_alias => '214672',
    p_owner => 'BUCH_ADMIN',
    p_status => '',
    p_description => ''
  );
end;
/

declare
  c  varchar2(32767) := null;
begin
wwv_flow_ws_import_api.create_section(
   p_id => 64050068046856999026837273829220530332+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 21467073131267679+wwv_flow_api.g_id_offset,
   p_display_sequence => 40,
   p_section_type => 'CHART',
   p_title => 'Fehlerliste',
   p_data_grid_id => 21468093859330789+wwv_flow_api.g_id_offset,
   p_report_id => 21470211919442362+wwv_flow_api.g_id_offset,
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_type => 'HCOLUMN',
   p_chart_3d => 'Y',
   p_chart_label => 'C003',
   p_chart_value => 'N001',
   p_chart_aggregate => 'COUNT',
   p_chart_sorting => 'DEFAULT'
   );
 
end;
/

declare
  c  varchar2(32767) := null;
begin
c:=c||'<p>Mit Websheet-Anwendungen können Endbenutzer strukturierte und nicht strukturierte Daten ohne Unterstützung durch den Entwickler verwalten. Mit Websheets können Benutzer:</p> '||chr(10)||
''||chr(10)||
'<ul>'||chr(10)||
'<li>Content über das Web mit einem Webbrowser erstellen und gemeinsam verwenden</li>'||chr(10)||
'<li>Seiten in einer Hierarchie organisieren und Seiten verknüpfen (mithilfe der [[ Seitenname ]]-Syntax).</li>'||chr(10)||
''||chr(10)||
'<li>Tabellarische D';

c:=c||'aten mithilfe eingebetteter Features, den so genannten Daten-Grids, erstellen und verwalten</li>'||chr(10)||
'<li>Interaktive Berichte mit SQL auf vorhandenen Datenstrukturen in der Datenbank erstellen.</li>'||chr(10)||
'<li>Daten-Grid- und Berichtsdaten in Seiten als Diagramm oder Bericht veröffentlichen.</li>'||chr(10)||
'<li>Seiten mit Anmerkungen in Form von Dateien, Tags und Hinweisen versehen. Zugehörige Images können inline im S';

c:=c||'eitencontent angezeigt werden (mithilfe der [[Image: Dateiname]]-Syntax).</li>'||chr(10)||
'<li>Seitencontent durchsuchen (mit der integrierten Suchfunktion).</li>'||chr(10)||
'<li>Verwalten, wer sich anmelden darf, und nach der Anmeldung kontrollieren, wer in der Anwendung lesen, schreiben oder sie verwalten darf (Authentifizierung und Autorisierung).</li>'||chr(10)||
'</ul>'||chr(10)||
'<p>Klicken Sie auf "Hilfe" für weitere Informationen.</p>';

wwv_flow_ws_import_api.create_section(
   p_id => 120091876920459276333435709177995393172+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 21467073131267679+wwv_flow_api.g_id_offset,
   p_display_sequence => 10,
   p_section_type => 'TEXT',
   p_title => 'Willkommen bei Websheets',
   p_content => c,
   p_content_upper => upper(wwv_flow_utilities.striphtml(c)),
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

declare
  c  varchar2(32767) := null;
begin
wwv_flow_ws_import_api.create_section(
   p_id => 180210592444985708279806698195214948936+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 21467073131267679+wwv_flow_api.g_id_offset,
   p_display_sequence => 30,
   p_section_type => 'DATA',
   p_title => 'Fehlerliste',
   p_content_upper => upper(wwv_flow_utilities.striphtml(c)),
   p_data_grid_id => 21468093859330789+wwv_flow_api.g_id_offset,
   p_report_id => 21468528673330803+wwv_flow_api.g_id_offset,
   p_data_section_style => 3,
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

declare
  c  varchar2(32767) := null;
begin
c:=c||'<p>Das sind Fehler</p>'||chr(10)||
'';

wwv_flow_ws_import_api.create_section(
   p_id => 230438049891558186589300435535397042867+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 21467073131267679+wwv_flow_api.g_id_offset,
   p_display_sequence => 20,
   p_section_type => 'TEXT',
   p_title => 'Fehlerlisten',
   p_content => c,
   p_content_upper => upper(wwv_flow_utilities.striphtml(c)),
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

prompt  ...Create Page
prompt  ...Create Annotations
begin
--application/end_environment
commit;
end;
/

begin
execute immediate 'begin sys.dbms_session.set_nls( param => ''NLS_NUMERIC_CHARACTERS'', value => '''''''' || replace(wwv_flow_api.g_nls_numeric_chars,'''''''','''''''''''') || ''''''''); end;';
end;
/

set verify on
set feedback on
prompt  ...done
