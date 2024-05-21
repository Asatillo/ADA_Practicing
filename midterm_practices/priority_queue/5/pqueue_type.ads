generic
    type Data is private;
    type Priority is (<>);
    with function "<" (A, B: Priority) return Boolean is <>;
package pqueue_type is
    type PQueue(Max: Integer) is private;

    procedure Insert (PQ : in out PQueue; P: in Priority; D: in Data);
    procedure Get (PQ : in PQueue; P: out Priority; D: out Data; Found: out Boolean);
    procedure Remove (PQ: in out PQueue; P: out Priority; D: out Data; Found: out Boolean);
    function Size (PQ: PQueue) return Integer;
    function "<"(A1, A2 : PQueue) return Boolean;
    function "+"(A1, A2 : PQueue) return PQueue;

    generic
        with procedure Action(P: in Priority; D: in Data);
    procedure ForEach(PQ: in out PQueue);

private
    function Contains (PQ: in PQueue; P: in Priority; D: Data) return Boolean;
    type DataArr is array(Integer range <>) of Data;
    type PriorityArr is array(Integer range <>) of Priority;

    type PQueue(Max: Integer) is record
        D: DataArr(1..Max);
        P: PriorityArr(1..Max);
        S: Integer := 0;
    end record;
end pqueue_type;


