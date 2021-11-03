create or replace package body utl_apex
as

  procedure bulk_replace(
    p_text in out nocopy varchar2,
    p_items in char_table)
  as
  begin
    p_text := bulk_replace(p_text, p_items);
  end bulk_replace;
  
    
  function bulk_replace(
    p_text in varchar2,
    p_items in char_table)
    return varchar2
  as
    l_result varchar2(32767);
  begin
    l_result := p_text;
    if p_items is not null then
      for i in p_items.first .. p_items.last loop
        if mod(i, 2) = 1 then
          l_result := replace(p_items(i), p_items(i+1));
        end if;
      end loop;
    end if;
    return l_result;
  end bulk_replace;
    
end utl_apex;
/