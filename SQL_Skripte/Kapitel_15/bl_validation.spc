create or replace package bl_validation
  authid definer
as
  
  procedure validate_iban(
    p_value in out nocopy varchar2,
    p_error_message out varchar2);
    
  procedure validate_bic(
    p_value in out nocopy varchar2,
    p_error_message out varchar2);

  procedure validate_special_value(
    p_type in varchar2,
    p_value in out nocopy varchar2,
    p_error_message out varchar2);

end bl_validation;
/