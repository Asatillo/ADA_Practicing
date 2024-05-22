generic
    type Element is (<>);
package Bag_Package is
    type Bag is private;

    procedure Add (b: in out Bag; elem : Element);
    procedure Remove (b: in out Bag; elem : Element);
private
    type MyArray is array (Element range <>) of Natural;
    type MyBoolArray is array (Element range <>) of Boolean;

    type Bag(max: Positive) is record
        data : MyArray(Element'First..Element'Last) := (others => False);
        tracker:  MyBoolArray(Element'First..Element'Last) := (others => False);
        curr_elem : Natural := 0;
    end record;

end Bag_Package;