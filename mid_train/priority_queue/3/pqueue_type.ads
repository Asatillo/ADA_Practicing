generic
    type Data is private;
    type Priority is (<>);
    with function "<" (A, B: Priority) return Boolean is <>;
package pqueu_type is
    type PQueue(Max: Integer) is private;

    procedure Insert (PQ : in out PQueue; P: in Priority; D: in Data);
    procedure Get (PQ : in PQueue; P: out Priority; D: out Data; Found: out Boolean);
    procedure Remove (PQ: in out PQueue; P: out Priority; D: out Data; Found: out Boolean);
    procedure Size (PQ: PQueue) return Integer;

private
    type DataArr is array(Integer range <>) of Data;
    type PriorityArr is array(Integer range <>) of Priority;

    type PQueue(Max: Integer) is record
        D: DataArr(1..Max);
        P: PriorityArr(1..Max);
        S: Integer := 0;
    end record;
end pqueu_type;


