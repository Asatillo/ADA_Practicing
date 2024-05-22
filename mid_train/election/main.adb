with Ada.Numerics.Discrete_Random, Ada.Text_IO;
use Ada.Text_IO;

with election_package;

procedure main is
    type Candidates is (Rasul, Bill, Jill, Will, Nill);
    type Regions is (Budapest, Pecs, Gyor, Debrecen, Szeged);

    package MyElectionPackage is new election_package(Candidates => Candidates, Regions => Regions);
    use MyElectionPackage;

    E : Election(5);
begin
    Initialize_Regional_Votes(E);
    Finalize_Votes(E);
    Print(E, True);
    Put_Line("=======================");
    Print(E, False);
    Put_Line("============Final_Vote_Of_Candidate Rasul===========");
    Put_Line(Final_Vote_Of_Candidate(E, Rasul)'Image);
    Put_Line("============Regional_Vote_Of_Candidate Bill===========");
    Put_Line(Regional_Vote_Of_Candidate(E, Budapest, Bill)'Image);

    Put_Line("===========First candidate============");
    Put_Line(Find_First_Place(E)'Image);

    Put_Line("===========Last candidate============");
    Put_Line(Find_Last_Place(E)'Image);

    Put_Line("===========First guy============");
    Put_Line(Find_N_th_Place(E, 1)'Image);
end main;