generic
    type Candidates is (<>);
    type Regions is (<>);



package elections_package is

    type Election(Count: Integer) is limited private;

    procedure Initialize_Regional_Votes (E : in out Election);
    procedure Finalize_Votes (E : in out Election);
    function Final_Vote_Of_Candidate(E : Election; C : Candidates) return Integer;
    function Regional_Vote_Of_Candidate(E : Election; R : Regions; C : Candidates) return Integer;

    function Find_First_Place (E : Election) return Candidates;
    function Find_Last_Place (E : Election) return Candidates;
--  * Implement `Find_N_th_Place` operation which will return candidate who has the nth most total votes.
    --  function Find_N_th_Place (E : Election; N : Integer) return Candidates;
    function compare_Candidates (E : Election; C1 : Candidates; C2 : Candidates) return Boolean;

    function Calculate_Percentage_Of_Candidate (E : Election; C : Candidates) return Float;
    function Calculate_Regional_Percentage_Of_Candidate (E : Election; R : Regions; C : Candidates) return Float;
    procedure Print(E: Election; B: Boolean := True);

    --  * Create a generic procedure `ForEach` inside the package with a region parameter, which performs an Action function parameter on the Region parameter and every candidate of the `Regional_Votes`. For example, if the Region is Budapest and the action is decreasing votes by 10 (this is the actual Action in the main program), then for all the votes of each candidate in the region Budapest, it should be decreased by 10.

    --  ** procedure ForEach ( E : in out Election; R : Regions );

    --  * In the demo

    --  ** Create a function my_action which takes an integer and returns it subtracted by 10. If votes go below 0, assign 0 to it.

    --  ** Instantiate my_ForEach using my_action function and test it extensively on the Elections.
    generic
        with function Action(V: Integer) return Integer;
    procedure ForEach(E: in out Election; R: Regions);
private
    type Regional_Votes_Array is  array(Regions, Candidates) of Integer;
    type Final_Votes_Array is array(Candidates) of Integer;
    type Election(Count: Integer) is record
        Regional_Votes: Regional_Votes_Array;
        Final_Votes: Final_Votes_Array := (others => 0);
    end record;
end elections_package;
