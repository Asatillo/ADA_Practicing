with Ada.Text_IO, utility;
use Ada.Text_IO, utility;

procedure factorial is
    n : Integer := 4;
begin
    Ada.Text_IO.Put_Line(Integer'Image(computeFactorial(n)));
end factorial;