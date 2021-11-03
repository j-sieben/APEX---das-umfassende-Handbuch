create or replace package utl_apex
  authid definer
as

  procedure bulk_replace(
    p_text in out nocopy varchar2,
    p_items in char_table);
    
  function bulk_replace(
    p_text in varchar2,
    p_items in char_table)
    return varchar2;
    
end utl_apex;
/