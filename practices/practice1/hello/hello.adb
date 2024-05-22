with Ada.Text_IO;

procedure Hello is
    A, B, C : Integer;
begin
    A := Integer'Value (Ada.Text_IO.Get_Line);
    B := Integer'Value (Ada.Text_IO.Get_Line);
    C := A + B;
    
    if C = 0 then
        Ada.Text_IO.Put_Line("Result is zero");
    elsif C > 0 then
        Ada.Text_IO.Put_Line("Positive result: " & Integer'Image (C));
    else
        Ada.Text_IO.Put_Line("Negative result: " & Integer'Image (C));
    end if;
end Hello;
