with Ada.Text_IO; use Ada.Text_IO;

procedure NChoose is
    N, K : Integer;

    function Factorial (N : Integer) return Integer is
        Res : Integer;
    begin
        Res := 1;
        for X in 2 .. N loop
            Res := Res * X;
        end loop;
        return Res;
    end Factorial;
begin
    N := Integer'Value (Ada.Text_IO.Get_Line);
    K := Integer'Value (Ada.Text_IO.Get_Line);

    --  Ada.Text_IO.Put_Line(Integer'Image(Factorial(N)));
    --  Ada.Text_IO.Put_Line(Integer'Image(Factorial(K)));
    --  Ada.Text_IO.Put_Line(Integer'Image(Factorial(N-K)));

    Ada.Text_IO.Put_Line(Integer'Image(Factorial(N) / (Factorial(K) * Factorial(N - K))));
end NChoose;
