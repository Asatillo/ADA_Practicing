with Ada.Text_IO;
use Ada.Text_IO;

procedure Sign is
    X : Integer;
    returnVal : Integer;
begin
    X := Integer'Value(Ada.Text_IO.Get_Line);

    case X is
        when 1 .. Integer'Last => returnVal := 1;
        when Integer'First .. -1 => returnVal := -1;
        when others => returnVal := 0;
    end case;

    Ada.Text_IO.Put_Line(Integer'Image(returnVal));
end Sign;