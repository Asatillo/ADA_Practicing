with Ada.Text_IO;
use Ada.Text_IO;

procedure Min is
    A, B : Integer;
begin

    A := Integer'Value(Ada.Text_IO.Get_Line);
    B := Integer'Value(Ada.Text_IO.Get_Line);

    if A < B then
        Ada.Text_IO.Put_Line("Minimum is" & Integer'Image(A));
    elsif B < A then
        Ada.Text_IO.Put_Line("Minimum is" & Integer'Image(B));
    else 
        Ada.Text_IO.Put_Line("Equal numbers");
    end if;

end Min;