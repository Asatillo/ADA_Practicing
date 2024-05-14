with Ada.Text_IO; use Ada.Text_IO;
with person_package; use person_package;
with stack_package; use stack_package;

procedure main is 
    --  person1 : Person;
    intStack1 : Stack(5);
begin
    --  Init("Asat", 23, person1);
    --  Print_Person(person1);
    --  PopInt(intStack1);

    PushInt(intStack1, 1);
    PushInt(intStack1, 2);
    PushInt(intStack1, 6);
    PushInt(intStack1, 2);
    PushInt(intStack1, 3);
    PushInt(intStack1, 5);
    Print_Stack(intStack1);

    PopInt(intStack1);
    Print_Stack(intStack1);

    PopInt(intStack1);
    Print_Stack(intStack1);

    PushInt(intStack1, 23);
    Print_Stack(intStack1);
end main;