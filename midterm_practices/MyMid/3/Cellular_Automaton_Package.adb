with Ada.Text_IO;

package body Cellular_Automaton_Package is
    --  * `Run(Cellular_Automaton, Natural)` executes the number of steps specified by the second parameter on the parameter  automaton. After each step, it draws the automaton and then waits for half a second (`delay 0.5;`).
    procedure Run(C: in out Cellular_Automaton; N: Natural) is
    begin
        for i in 1..N loop
            Iterate(c);
            Put(c);
            delay 0.5;
        end loop;
    end;
    --  * `Iterate(Cellular_Automaton)` applies the rules to the previous state of the automaton and then updates the state of the parameter automaton with the new values, call this cell trajectory. Make sure to use the state of the previous track!
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
    --  * `Put(Cellular_Automaton)` prints the trajectory of the automaton. (It is advisable to write a dividing line as well, and a space between elements.)
    procedure Put(C: Cellular_Automaton) is
    begin
        for i in C.board'Range(1) loop
            for j in C.board'Range(2) loop
                Ada.Text_IO.Put(C.board(i, j)'Image & " ");
            end loop;
            Ada.Text_IO.New_Line;
        end loop;
    end;
end Cellular_Automaton_Package;