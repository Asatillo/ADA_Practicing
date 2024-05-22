generic
    type Candidates is (<>);
    type Regions is (<>);
package election_package is
    --  grade 2
    type Election(Count: Integer) is limited private;
    
    procedure Initialize_Regional_Votes (E : in out Election);
    procedure Finalize_Votes (E : in out Election);
    function Final_Vote_Of_Candidate(E : Election; C : Candidates) return Integer;
    function Regional_Vote_Of_Candidate(E : Election; R : Regions; C : Candidates) return Integer;

    --  Grade 3
    function Find_First_Place (E : Election) return Candidates;
    function Find_Last_Place (E : Election) return Candidates;
    function Find_N_th_Place (E : Election; N : Integer) return Candidates;
    --  function compare_Candidates (E : Election; C1 : Candidates; C2 : Candidates) return Boolean;

    --  Grade 4
    procedure Print (E : Election; B : Boolean := True);


    --  utils
    function RandInt return Integer;
private
    type vote_matrix is array(Regions range <>, Candidates range <>) of Integer; 
    type vote_array is array(Candidates range <>) of Integer;
    
    type Election(Count: Integer) is record
        Regional_Votes : vote_matrix(Regions'Range, Candidates'Range) := (others => (others => 0));
        Final_Votes : vote_array(Candidates'Range) := (others => 0);
    end record;
end election_package;