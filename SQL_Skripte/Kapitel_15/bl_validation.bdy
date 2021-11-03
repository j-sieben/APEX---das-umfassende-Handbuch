create or replace package body bl_validation 
as

  function check_iban(
    p_iban varchar2)
    return varchar2
  as
    l_length pls_integer;
    l_iban_swapped varchar2(34);
    l_char char(1 byte);
    l_ascii pls_integer;
    l_ascii_normalized pls_integer;
    l_remainder pls_integer := 0;
    
    c_min_length pls_integer := 5;
    c_max_length pls_integer := 34;
  begin
    if p_iban is null then
      return null; -- no argument
    end if;
    
    -- Laenge pruefen
    l_length := length(p_iban);
    pit.assert(
      l_length between c_min_length and c_max_length,
      msg.IBAN_INVALID_LENGTH, 
      msg_args(to_char(c_min_length), to_char(c_max_length)));
  
    -- Die ersten vier Zeichen ans Ende des IBAN anfuegen
    l_iban_swapped := upper(substr(p_iban, 5) || substr(p_iban, 1, 4));
  
    -- Uebe IBAN iterieren
    for i in 1 .. l_length loop
      l_char := substr(l_iban_swapped, i, 1);
      l_ascii := ascii(l_char);
  
      -- Normalyze the code to the range 0-35
      case 
      when l_ascii between 48 and 57 then
        -- Zahl
        pit.assert(i not between l_length - 3 and l_length - 2, msg.IBAN_INVALID_SYMBOL, msg_args(l_char, '1-2'));
        l_ascii_normalized := l_ascii - 48;
      when l_ascii between 65 and 90 then
        -- Grossbuchstabe
        pit.assert(i not between l_length - 1 and l_length, msg.IBAN_INVALID_SYMBOL, msg_args(l_char, '3-4'));
        l_ascii_normalized := l_ascii - 55;
      -- case: other symbol
      else
        -- Sonstiges Symbol
        pit.error(msg.IBAN_INVALID_SYMBOL, msg_args(l_char, to_char(i)));
      end case;
  
      -- Summiere den Modulo 97 des ASCII-Codes
      if l_ascii_normalized > 9 then
        l_remainder := (100 * l_remainder + l_ascii_normalized) mod 97;
      else
        l_remainder := (10 * l_remainder + l_ascii_normalized) mod 97;
      end if;
    end loop;
  
    pit.assert(l_remainder = 1, msg.IBAN_INVALID_CHECKSUM);
    return null;
  exception
    when others then
      return sqlerrm;
  end check_iban;
  
  
  function format_iban(
    p_iban in varchar2)
    return varchar2
  as
    l_iban varchar2(50);
    l_length pls_integer;
    l_position pls_integer;
    c_chunk_size pls_integer := 4;
  begin
    l_iban := upper(p_iban);
    l_length := length(p_iban)/c_chunk_size;
    for i in reverse 1 .. l_length loop
      l_position := i * c_chunk_size;
      l_iban := substr(l_iban, 1, l_position) || ' ' || substr(l_iban, l_position + 1); 
    end loop;
    return l_iban;
  end format_iban;
  

  procedure validate_iban(
    p_value in out nocopy varchar2,
    p_error_message out varchar2) as
  begin
    p_error_message := check_iban(p_value);
    if p_error_message is null then
      p_value := format_iban(p_value);
    end if;
  end validate_iban;
  
  
  procedure validate_bic(
    p_value in out nocopy varchar2,
    p_error_message out varchar2) 
  as
    begin
    -- TODO: Implementation required for procedure BL_VALIDATION.validate_bic
    null;
  end validate_bic;
  
  
  procedure validate_special_value(
    p_type in varchar2,
    p_value in out nocopy varchar2,
    p_error_message out varchar2)
  as
  begin
    case p_type
    when 'IBAN' then validate_iban(p_value, p_error_message);
    when 'BIC' then validate_bic(p_value, p_error_message);
    else
      pit.error(msg.INVALID_SPECIAL_TYPE, msg_args(p_type));
    end case;
  end validate_special_value;
  
  
end bl_validation;
/