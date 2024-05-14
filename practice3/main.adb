with Ada.Text_IO; use Ada.Text_IO;
with arrays; use arrays;
with Matrix_pack; use Matrix_pack;

procedure main is 
    Arr : My_Int_Array := (5, 4, 3, 2, 1);
    M : Matrix := ((1,2,4), 
                    (3,1,6), 
                    (6,2,6));
begin
    --  Ada.Text_IO.Put(My_Int'Image(sum(Arr, Arr'First, Arr'Last)));

    --  bubbleSort(Arr);

    Ada.Text_IO.Put(Elem'Image(computeDiagSum(M)));
end main;