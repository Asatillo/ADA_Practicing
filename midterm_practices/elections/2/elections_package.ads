generic
    type Candidates is (<>);
    type Regions is (<>);



package elections_package is

    type Election(Count: Integer) is limited private;

    procedure Initialize_Regional_Votes (E : in out Election);
    procedure Finalize_Votes (E : in out Election);
    function Final_Vote_Of_Candidate(E : Election; C : Candidates) return Integer;
    function Regional_Vote_Of_Candidate(E : Election; R : Regions; C : Candidates) return Integer;

    procedure Print(E: Election; B: Boolean := True);
private
    type Regional_Votes_Array is  array(Regions, Candidates) of Integer;
    type Final_Votes_Array is array(Candidates) of Integer;
    type Election(Count: Integer) is record
        Regional_Votes: Regional_Votes_Array;
        Final_Votes: Final_Votes_Array := (others => 0);
    end record;
end elections_package;
