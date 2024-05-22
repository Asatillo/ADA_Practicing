with Ada.Text_IO, max_elem;
use Ada.Text_IO;

procedure Main is
    type IndType is new Integer range 1..10;
    type CustArray is array (IndType range <>) of Integer;
    function my_max_arr is new max_elem(Integer, IndType, CustArray);

    my_arr : CustArray := (1,3,4,5,6,2);
begin
    Put_Line(Integer'Image(my_max_arr(my_arr)));
end Main;