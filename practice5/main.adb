with Bag_Package;
with Ada.Text_IO; use Ada.Text_IO;

procedure main is
    type MySmallInt is new Integer range 1 .. 10; 
    package MyIntBag is new Bag_Package(Element => MySmallInt);
    use MyIntBag;

    --  procedure mutlitplyFrequencyByTwo(elem : in out Natural) is
    --  begin
    --      freq := freq * 2;
    --  end ;

    procedure FancyPrint(elem : in MySmallInt) is
    begin
        Put_Line("Changing frequency of"&elem'img);
    end;

    procedure MyForEach is new MyIntBag.For_Each(Process_Elem => FancyPrint);

    intBag : Bag(3);
begin
    Print(intBag);
    Add(intBag, 1);
    Add(intBag, 2);
    Add(intBag, 2);
    Add(intBag, 1);
    Add(intBag, 3);
    Print(intBag);
    MyForEach(intBag);
end main;