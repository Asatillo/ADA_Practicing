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

end pqueu_type;