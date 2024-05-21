with Ada.Text_IO;
use Ada.Text_IO;

package body pqueu_type is

    procedure Insert (PQ : in out PQueue; P: in Priority; D: in Data) is
        I: Integer;
        B: Boolean := False;
    begin
        if PQ.S = PQ.Max then
            Put_Line("Queus is full");
            return;
        end if;

        I := PQ.S + 1;

        while not B loop
            if I = 1 then
                PQ.P(I) := P;
                PQ.D(I) := D;
                B := True;
            elsif PQ.P(I-1) < P then
                PQ.P(I) := PQ.P(I-1);
                PQ.P(I) := PQ.D(I-1);
            else
                PQ.P(I) := P;
                PQ.D(I) := D;
            end if;
            I := I + 1;
        end loop;
        PQ.S := PQ.S + 1;
    end Insert;

    procedure Get (PQ : in PQueue; P: out Priority; D: out Data; Found: out Boolean) is 
    begin
        if PQ.S > 0 then
            P := PQ.P(1);
            D := PQ.D(1);
            Found := True;
        else
            Found := False;
        end if;
    end Get;

    procedure Remove (PQ: in out PQueue; P: out Priority; D: out Data; Found: out Boolean) is
    begin
        if PQ.S > 0 then
            P := PQ.P(1);
            D := PQ.D(1);
            Found := True;
        else
            Found := False;
        end if;

        if Found then
            PQ.S := PQ.S - 1;
            for i in 1..PQ.S loop
                PQ.D(I) := PQ.D(I + 1);
                PQ.D(I) := PQ.P(I + 1);
            end loop;
        end if;
    end Remove;

    procedure Size (PQ: PQueue) return Integer;
    begin
        return PQ.S;
    end Size;

    function "<"(A1, A2 : PQueue) return Boolean is
        P1, P2 : Priority;
        D1, D2 : Data;
        B1, B2 : Boolean;
    begin
        Get(A1, P1, D1, B1);
        Get(A2, P2, D2, B2);
        if B1 and B2 then
            return P1 < P2;
        else
            Put_Line("One of the queues is empty");
            return False;
        end if;
    end;

    function Contains (PQ: in PQueue; P: in Priority; D: Data) return Boolean is
    begin
        for i in 1..PQ.S loop
            if PQ.D(I) = D and PQ.P(i) = P then
                return TRUE;
            end if;
        end loop;
        return False;
    end Contains;
    
    function "+"(A1, A2 : PQueue) return PQueue is
        Q1: PQueue := A1;
        Q2: PQueue := A2;
        P: Priority;
        D: Data;
        B: Boolean;
    begin
        Remove(Q2, P, D, B);
        while B loop
            if not Containes(Q1, P, D) then
                Insert(Q1, P, D);
            end if;
            Remove(Q2, P, D, B);
        end loop;
        return Q1;
    end;

end pqueu_type;