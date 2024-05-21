with Ada.Numerics.Discrete_Random, Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;

package body elections_package is

    procedure Initialize_Regional_Votes (E : in out Election) is
        package Random_int is new Ada.Numerics.Discrete_Random (Integer);
        G : Random_int.Generator;
    begin
        Random_int.Reset(G);

        for i in E.Regional_Votes'Range(1) loop
            for j in E.Regional_Votes'Range(2) loop
                E.Regional_Votes(i, j) := Random_int.Random(G) mod 50 + 1;
            end loop;
        end loop;
    end;

    procedure Finalize_Votes (E : in out Election) is
    begin
        for i in E.Regional_Votes'Range(1) loop
            for j in E.Regional_Votes'Range(2) loop
                E.Final_Votes(j) := E.Final_Votes(j) + E.Regional_Votes(i, j);
            end loop;
        end loop;
    end;

    function Final_Vote_Of_Candidate(E : Election; C : Candidates) return Integer is
        final_votes : Integer := 0;
    begin
        for i in E.Regional_Votes'Range(1) loop
            final_votes := final_votes + E.Regional_Votes(i, C);
        end loop;

        return final_votes;
    end;

    function Regional_Vote_Of_Candidate(E : Election; R : Regions; C : Candidates) return Integer is
    begin
        return E.Regional_Votes(R, C);
    end;

    procedure Print(E: Election; B: Boolean := True) is 
    begin
        if B then
            Put_Line("=== Regional Votes ===");
            for i in E.Regional_Votes'Range(1) loop
                for j in E.Regional_Votes'Range(2) loop
                    Put(E.Regional_Votes(i, j)'Image & " ");
                end loop;
                New_Line;
            end loop;
        else
            Put_Line("=== Final Votes ===");
            for i in E.Final_Votes'Range loop
                Put(E.Final_Votes(i)'Image & " ");
            end loop;
            New_Line;
        end if;
    end;

end elections_package;