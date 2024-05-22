with Ada.Text_IO;

package body Cellular_Automaton_Package is
    procedure Run(C: in out Cellular_Automaton; N: Natural) is
    begin
        for i in 1..N loop
            Iterate(c);
            Put(c);
            delay 0.5;
        end loop;
    end;

    procedure Iterate(C: in out Cellular_Automaton) is
        copyC : Cellular_Automaton := c;
    begin
        for i in C.board'Range(1) loop
            for j in C.board'Range(2) loop
                copyC.board(i, j) := Rule(c.board(i, j));
            end loop;
        end loop;

        c := copyC;
    end;

    procedure Put(C: Cellular_Automaton) is
    begin
        for i in C.board'Range(1) loop
            for j in C.board'Range(2) loop
                Ada.Text_IO.Put(C.board(i, j)'Image & " ");
            end loop;
            Ada.Text_IO.New_Line;
        end loop;
    end;

    procedure Init ( InCA : in CoordinateArray; OutCA : out Cellular_Automaton ) is
    begin
        for i in InCA'Range loop
            OutCA.board(InCA(i).X, InCA(i).Y) := InCA(i).Value;
        end loop;
    end;

    function isAlive(c: Cell) return Boolean is
    begin
        return c = Cell'Last;
    end;
end Cellular_Automaton_Package;