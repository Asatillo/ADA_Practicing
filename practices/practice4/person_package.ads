package person_package is
    type Person is private;

    procedure Init(param_name : String; param_age : Natural; person_obj : out Person);

    function Init(param_name : String; param_age : Natural) return Person;

    procedure Print_Person(person_obj : Person);

private
    type Person is record
        name : String(1..4) := "name";
        age : Natural;
    end record;
end person_package;