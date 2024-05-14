with Ada.Text_IO; use Ada.Text_IO;

package body arrays is
    function sum (arr : My_Int_Array; first, last : Index) return My_Int is
    begin
        if first = last then
            return arr (first);
        else
            return (arr (first) + sum (arr, first + 1, last));
        end if;
    end sum;

    procedure bubbleSort (arr : in out My_Int_Array) is
        swapped : Boolean;
        temp : My_Int;
    begin

        for i in arr'Range loop
            swapped := False;
            for j in arr'First .. (arr'Last - i) loop
                if arr(j) > arr(j+1) then
                    temp := arr(j);
                    arr(j) := arr(j+1);
                    arr(j+1) := temp;
                    swapped := true;
                end if;
            end loop;

            if not swapped then
                exit;
            end if;
        end loop;

        printArray(arr);
    end bubbleSort;

    procedure printArray(Arr : My_Int_Array) is
    begin
        for i in arr'Range loop
            Ada.Text_IO.Put(My_Int'Image(arr(i)));
        end loop;
    end printArray;
end arrays;
