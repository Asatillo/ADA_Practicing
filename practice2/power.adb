with Ada.Text_IO; use Ada.Text_IO;
with utility; use utility;

procedure power is
    x, n : Positive;
begin
    x := 10;
    n := 2;

    Ada.Text_IO.Put_Line(Positive'Image(computePower(x, n)));
end power;