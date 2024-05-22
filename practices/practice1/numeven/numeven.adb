with Ada.Text_IO;
use Ada.Text_IO;

procedure numeven is
    Num : Integer;
begin
    Num := Integer'Value(Ada.Text_IO.Get_Line);

    Ada.Text_IO.Put(Boolean'Image(Num mod 2 = 0));

end numeven;