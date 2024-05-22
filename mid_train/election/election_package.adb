with Ada.Numerics.Discrete_Random, Ada.Text_IO;
use Ada.Text_IO;

package body election_package is


    --  grade 2
    function RandInt return Integer is 
        package Random_Int is new Ada.Numerics.Discrete_Random(Integer);
        G: Random_Int.Generator;
    begin
        Random_Int.Reset(G);
        return Random_Int.Random(G) mod 51;
    end;

    procedure Initialize_Regional_Votes (E : in out Election) is
    begin
        for i in E.Regional_Votes'Range(1) loop
            for j in E.Regional_Votes'Range(2) loop
                E.Regional_Votes(i, j) := RandInt;
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
    begin
        return E.Final_Votes(C);
    end;

    function Regional_Vote_Of_Candidate(E : Election; R : Regions; C : Candidates) return Integer is 
    begin
        return E.Regional_Votes(R, C);
    end;

    --  grade 3
    function Find_First_Place (E : Election) return Candidates is 
        max : Candidates := Candidates'First; 
    begin
        for candidate in Candidates'First .. Candidates'Last loop
            if Final_Vote_Of_Candidate(E, max) < Final_Vote_Of_Candidate(E, candidate) then
                max := candidate;
            end if;
        end loop;
        return max;
    end;

    function Find_Last_Place (E : Election) return Candidates is
    min : Candidates := Candidates'First; 
    begin
        for candidate in Candidates'First .. Candidates'Last loop
            if Final_Vote_Of_Candidate(E, min) > Final_Vote_Of_Candidate(E, candidate) then
                min := candidate;
            end if;
        end loop;
        return min;
    end;

    function Find_N_th_Place (E : Election; N : Integer) return Candidates is
        temp: Election := E;

        tempVote: Integer;
        cnt : Integer := 1;

        type candArray is array(Integer range 1..N) of Candidates;

        finaVotes : candArray;
    begin
        for i in temp.Final_Votes'First..Candidates'Pred(temp.Final_Votes'Last) loop
            for j in Candidates'Succ(temp.Final_Votes'First)..temp.Final_Votes'Last loop
                if temp.Final_Votes(i) > temp.Final_Votes(j) then
                    tempVote := temp.Final_Votes(i);
                    temp.Final_Votes(i) := temp.Final_Votes(j);
                    temp.Final_Votes(j) := tempVote;
                end if;
            end loop;
        end loop;

        for c in temp.Final_Votes'Range loop
            if cnt = N then
                return c;
            end if;
            cnt := cnt + 1;
        end loop;

        return temp.Final_Votes'First;
    end;
    --  function compare_Candidates (E : Election; C1 : Candidates; C2 : Candidates) return Boolean;
    --  grade 4
    procedure Print (E : Election; B : Boolean := True) is 
    begin
        if B then
            for i in E.Regional_Votes'Range(1) loop
                for j in E.Regional_Votes'Range(2) loop
                    Put(E.Regional_Votes(i, j)'Image);
                end loop;
                New_Line;
            end loop;
        else
            for i in E.Final_Votes'Range loop
                Put_Line(I'img& ":" &E.Final_Votes(i)'Image);
            end loop;
            New_Line;
        end if;
    end;

end election_package;