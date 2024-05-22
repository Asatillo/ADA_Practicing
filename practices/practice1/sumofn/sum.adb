with Ada.Text_IO;
use Ada.Text_IO;

procedure Sum is
    Sum, N : Integer;
begin

    N := Integer'Value(Ada.Text_IO.Get_Line);
    Sum := 0;
    for I in 1 .. N loop
        Sum := Sum + I;
    end loop;

    Ada.Text_IO.Put(Integer'Image(Sum));
end Sum;