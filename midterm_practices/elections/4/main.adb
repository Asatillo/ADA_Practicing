with Ada.Text_IO, elections_package;
use Ada.Text_IO;

procedure Main is
    type Candidates is (Rasul, Bill, Jill, Will, Nill);
    type Regions is (Budapest, Pecs, Gyor, Debrecen, Szeged);

    package myElectionsPackage is new elections_package(Candidates, Regions);
    use myElectionsPackage;

    function my_action(num: Integer) return Integer is
    begin
        if num < 10 then 
            return 0;
        else
            return num - 10;
        end if; 
    end;
    myElection : Election(5);
    
    function my_ForEach is new myElectionsPackage.ForEach(myElection, Regions);
    use my_ForEach;
    
begin
    Initialize_Regional_Votes(myElection);
    Finalize_Votes(myElection);

    

    Print(myElection);
    Print(myElection, False);

    Put_Line("Final votes for Rasul: " & Final_Vote_Of_Candidate(myElection, Rasul)'Image);
    Put_Line("Votes of Nill in Budapest: " & Regional_Vote_Of_Candidate(myElection, Budapest, Nill)'Image);

    Put_Line("First place is: " & Find_First_Place(myElection)'Image);
    Put_Line("Last place is: " & Find_Last_Place(myElection)'Image);
    Put_Line("Does Rasul have more votes than Bill: " & compare_Candidates(myElection, Rasul, Bill)'Image);

    Put_Line("Rasuls percentage in the elections: " & Calculate_Percentage_Of_Candidate(myElection, Rasul)'Image);
    Put_Line("Jills percentage in the Debrecen elections: " & Calculate_Regional_Percentage_Of_Candidate(myElection, Debrecen, Jill)'Image);
end Main;