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

    function Find_First_Place (E : Election) return Candidates is
        max: Candidates := Candidates'First;
    begin
        for i in E.Final_Votes'Range loop
            if E.Final_Votes(i) > E.Final_Votes(max) then
                max := I;
            end if;
        end loop;
        return max;
    end;

    function Find_Last_Place (E : Election) return Candidates is
        min: Candidates := Candidates'First;
    begin
        for i in E.Final_Votes'Range loop
            if E.Final_Votes(i) < E.Final_Votes(min) then
                min := I;
            end if;
        end loop;
        return min;
    end;

    function compare_Candidates (E : Election; C1 : Candidates; C2 : Candidates) return Boolean is
    begin
        return E.Final_Votes(C1) > E.Final_Votes(C2);
    end;

    function Calculate_Percentage_Of_Candidate (E : Election; C : Candidates) return Float is
        total_votes : Integer := 0;
    begin
        for i in E.Final_Votes'Range loop
            total_votes := total_votes + e.Final_Votes(i);
        end loop;

        return Float(100 * e.Final_Votes(C)) / Float(total_votes);
    end;

    function Calculate_Regional_Percentage_Of_Candidate (E : Election; R : Regions; C : Candidates) return Float is
        total_regional : Integer := 0;
    begin
        for i in E.Regional_Votes'Range(2) loop
            total_regional := total_regional + e.Regional_Votes(R, i);
        end loop;

        return Float(100 * e.Regional_Votes(R, C)) / Float(total_regional);
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

    procedure ForEach(E: in out Election; R: Regions) is
    begin
        for j in E.Regional_Votes'Range(2) loop
            S := Action(E.Regional_Votes(R, j));
            E.Regional_Votes(R, j) := S;
        end loop;
    end;
end elections_package;