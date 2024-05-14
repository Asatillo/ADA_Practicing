with Ada.Text_IO;
use Ada.Text_IO;

procedure Max is 
    A, B : Integer;
begin
    A := Integer'Value(Ada.Text_IO.Get_Line);
    B := Integer'Value(Ada.Text_IO.Get_Line);

    if A > B then
        Ada.Text_IO.Put_Line("Max is" & Integer'Image(A));
    elsif B > A then
        Ada.Text_IO.Put_Line("Max is" & Integer'Image(B));
    else
        Ada.Text_IO.Put_Line(Integer'Image(B) & "=" & Integer'Image(A));
    end if;
end Max;