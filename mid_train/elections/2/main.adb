with Ada.Text_IO, elections_package;
use Ada.Text_IO;

procedure Main is
    type Candidates is (Rasul, Bill, Jill, Will, Nill);
    type Regions is (Budapest, Pecs, Gyor, Debrecen, Szeged);

    package myElectionsPackage is new elections_package(Candidates, Regions);
    use myElectionsPackage;
    
    myElection : Election(5);
begin
    Initialize_Regional_Votes(myElection);
    Finalize_Votes(myElection);

    

    Print(myElection);
    Print(myElection, False);

    Put_Line("Final votes for Rasul: " & Final_Vote_Of_Candidate(myElection, Rasul)'Image);

    Put_Line("Votes of Nill in Budapest: " & Regional_Vote_Of_Candidate(myElection, Budapest, Nill)'Image);
end Main;