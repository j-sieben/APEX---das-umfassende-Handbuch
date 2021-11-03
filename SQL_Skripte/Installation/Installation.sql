-- Skript als Benutzer SYSTEM ausfuehren!
-- Das Skript erzeugt einen Benutzer &APEX_USER. und erteilt die Rollenrechte CONNECT und RESOURCE.
-- Zudem werden die direkten Rechte CREATE VIEW, CREATE MATERIALIZED VIEW und CREATE SYSNONYM erteilt,
-- weil diese in der Resource-Rolle fehlen.
-- Voraussetzung ist, dass der Benutzer HR existiert. Er muss nicht entsperrt werden, eine direkte
-- Anmeldung als HR erfolgt nicht.

set echo off
set termout on
set verify off
set serveroutput on
whenever sqlerror exit

define APEX_USER=APEX_BUCH
define APEX_PWD=buch
define APEX_WS=USERS


@Datenmodell.sql

alter session set current_schema = &APEX_USER.;

@APEX_BUCH_Workspace.sql