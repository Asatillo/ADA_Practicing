with Ada.Text_IO; use Ada.Text_IO;

procedure main is 
    type StringPtr is access String;

    type Person is record
        age: Integer;
        name: StringPtr;
    end record;

    type PersonPtr is access Person;
    
    MyExcep : exception;

    ptr1 : PersonPtr;

    procedure print_hi is
    begin
        raise MyExcep;
    exception
        when MyExcep =>
            Put_Line("Exception");
    end;
begin
    print_hi;
    ptr1 := new Person'(age => 2, name=> new String'("Carlson"));
    Put_Line(Integer'Image(ptr1.all.age) & " " & ptr1.all.name.all);

    ptr1.age := 29;
    ptr1.name := new String'("Wils");
    Put_Line(Integer'Image(ptr1.all.age) & " " & ptr1.all.name.all);
end;