package arrays is
    type My_Int is range 0 .. 1_000;
    type Index is range 1 .. 5;
    type My_Int_Array is array (Index) of My_Int;

    function sum (arr : My_Int_Array; first, last: Index) return My_Int;

    procedure bubbleSort (arr : in out My_Int_Array);

    procedure printArray(Arr : My_Int_Array);
end arrays;