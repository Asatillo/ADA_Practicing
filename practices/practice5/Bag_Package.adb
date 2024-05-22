with Ada.Text_IO; use Ada.Text_IO;

package body Bag_Package is

    procedure Add(b : in out Bag; elem : Element) is 
    begin
        if b.curr_elem = b.max then
            Put_Line("Bag is full!");
            return;
        end if;

        if not b.tracker(elem) then 
            b.tracker(elem) := true;
            b.curr_elem := b.curr_elem + 1;
        end if;

        b.data(elem) := b.data(elem) + 1;
    end Add;

    procedure Remove(b : in out Bag; elem : Element) is 
    begin 
        if b.curr_elem = 0 then 
            Put_Line("Bag is empty!");
            return;
        end if;

        if b.tracker(elem) = False then
            Put_Line("No such element");
            return;
        end if;

        b.data(elem) := b.data(elem) - 1;

        if b.data(elem) = 0 then
            b.tracker(elem) := False;
            b.curr_elem := b.curr_elem + 1;
        end if;
    end Remove;

    procedure For_Each(b: in out Bag) is
    begin
        for i in b.data'Range loop
            if b.tracker(i) then
                Process_Elem(i);
            end if;
        end loop;
    end For_Each;

    procedure Print(b: Bag) is
    begin
        for i in b.data'Range loop
            if b.tracker(i) then
                Put_Line(i'Image&":"&b.data(i)'Image);
            end if;
        end loop;
    end Print;

end Bag_Package;