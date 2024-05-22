with Ada.Text_IO; use Ada.Text_IO;

package body person_package is 

    procedure Init(param_name : String; param_age : Natural; person_obj : out Person) is

    begin
        person_obj.name := param_name;
        person_obj.age := param_age;
    end Init;

    function Init(param_name : String; param_age : Natural) return Person is
        new_person : Person;
    begin 
        new_person.name := param_name;
        new_person.age := param_age;

        return new_person;
    end Init;

    procedure Print_Person(person_obj : Person) is 

    begin
        Ada.Text_IO.Put_Line("name: "&person_obj.name&", age:"&person_obj.age'Image);
    end Print_Person;

end person_package;