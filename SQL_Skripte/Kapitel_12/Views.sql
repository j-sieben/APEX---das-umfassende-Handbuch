--------------------------------------------------------
--  DDL for View EMP_UI_HOME_ALERT
--------------------------------------------------------

create or replace view emp_ui_home_alert as 
  select dep_id,
       case
       when max(emp_salary) - min(emp_salary) <= 5000 then 'success'
       when max(emp_salary) - min(emp_salary) <= 8000 then 'warning'
       else 'danger' end alert_type,
       dep_name alert_title,
       'Mitarbeiter: ' || count(*) || ', Spreizung: ' || (max(emp_salary) - min(emp_salary)) alert_desc,
       apex_page.get_url(
         p_page => 'EMP_REPORT',
         p_items => 'P2_DEP_ID', 
         p_values => dep_id) alert_action
  from dl_employees emp
  join dl_departments dep
    on emp.emp_dep_id = dep.dep_id
having count(*) > 1
 group by dep.dep_id, dep.dep_name;

--------------------------------------------------------
--  DDL for View EMP_UI_HOME_CHART
--------------------------------------------------------

create or replace view emp_ui_home_chart as 
  select count(emp.emp_id) emp_amount, cou.cou_id, cou.cou_name
  from dl_employees emp
  join dl_departments dep on emp.emp_dep_id = dep.dep_id
  join dl_locations loc on dep.dep_loc_id = loc.loc_id 
  join dl_countries cou on loc.loc_cou_id = cou.cou_id
 group by cou.cou_id, cou.cou_name;

--------------------------------------------------------
--  DDL for View EMP_UI_HOME_COMMENT
--------------------------------------------------------

create or replace view emp_ui_home_comment as 
  with data as(
       select cou_name, loc_city, count(*) amount, row_number() over (partition by cou_name order by loc_city) sort_seq
         from dl_countries cou
         join dl_locations loc
           on cou.cou_id = loc.loc_cou_id
         join dl_departments dep
           on loc.loc_id = dep.dep_loc_id
        group by cou_name, loc_city)
select cou_name search_title,
       'Anzahl der Niederlassungen pro Stadt in  »' || cou_name || '«' search_desc,
       apex_page.get_url as search_link,
       g1_label as label_01, g1_amount as value_01, 
       g2_label as label_02, g2_amount as value_02, 
       g3_label as label_03, g3_amount as value_03, 
       g4_label as label_04, g4_amount as value_04
  from data
 pivot (max(loc_city) as label, max(amount) as amount
        for sort_seq in
          (1 as g1,
           2 as g2,
           3 as g3,
           4 as g4));
