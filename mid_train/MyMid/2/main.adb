with Ada.Text_IO, Adjacent_Count;
use Ada.Text_IO;

procedure main is
    type MyArray is array(Positive range <>, Positive range <>) of Integer;
    function isEven(val : Integer) return Boolean is
    begin
        return val mod 2 = 0;
    end isEven;

    function Even_Adjacents is new Adjacent_Count(Integer, Positive, MyArray, isEven);

    M : MyArray(1..5, 1..5);

begin
    for I in M'range(1) loop
        for J in M'range(2) loop
            M(I, J) := Integer(I * J);
            Ada.Text_IO.Put(Integer'Image(M(I,J)));
        end loop;
        Ada.Text_IO.New_Line;
    end loop;

    Ada.Text_IO.Put_Line( Integer'Image( Even_Adjacents(M, 1, 1) )); --3
    Ada.Text_IO.Put_Line( Integer'Image( Even_Adjacents(M, 3, 3) )); --8
    Ada.Text_IO.Put_Line( Integer'Image( Even_Adjacents(M, 4, 5) )); --3
    Ada.Text_IO.Put_Line( Integer'Image( Even_Adjacents(M, 5, 5) )); --3
end Main;