with Ada.Text_IO, utility;
use Ada.Text_IO, utility;

procedure PerfectNumber is
    Sum : Integer;
begin
    for I in 1 .. 10000 loop
        Sum := getSumOfDivisors(I);
        if Sum = I then
            Ada.Text_IO.Put_Line(Sum'Img);
        end if;
    end loop;

end PerfectNumber;