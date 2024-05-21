with Ada.Text_IO;
use Ada.Text_IO;

package body Bag_Package is
    procedure Add (b: in out Bag; elem : Element) is
    begin
        if b.curr_elem > b.max then
            Put_Line("Bag is Full!");
            return;
        end if; 

        b.data(elem) := b.data(elem) + 1;
        b.curr_elem := b.curr_elem + 1;
    end;

    procedure Remove (b: in out Bag; elem : Element) is
    begin
        if b.curr_elem = 0 then
            Put_Line("Bag is Empty!");
            return;
        end if; 

        b.data(elem) := b.data(elem) - 1;
        b.curr_elem := b.curr_elem - 1;
    end;

end Bag_Package;