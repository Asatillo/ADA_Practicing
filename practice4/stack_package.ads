package stack_package is
    type Stack(max : Positive) is private;

    procedure PushInt(s: in out Stack; elem: Integer);
    procedure PopInt(S: in out Stack);
    procedure Print_Stack(s: Stack);
private

    type IntArray is array (Integer range <>) of Integer;

    type Stack(max: Positive) is record

        data : IntArray (1 .. max);
        ptr : Positive := 1;
    end record;
end stack_package;
