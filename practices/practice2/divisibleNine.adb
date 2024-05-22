with Ada.Text_IO;
use Ada.Text_IO;

with AddDigits;

procedure DivisibleNine is
    Num, Sum : Integer;
begin
    
    Num := Integer'Value(Ada.Text_IO.Get_Line);
    Sum := AddDigits(Num);
    Ada.Text_IO.Put_Line(Boolean'Image((Sum mod 9 = 0)));
end DivisibleNine;
