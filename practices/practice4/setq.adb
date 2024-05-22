with gcd; 
with lcm;

with Ada.Text_IO; use Ada.Text_IO;

package body Setq is

    function Numerator ( R: Rational ) return Integer is
    begin
        return R.Numerator;
    end;

    function Denominator ( R: Rational ) return Positive is
    begin
        return R.Denominator;
    end;

    function Normalize ( Numerator: Integer; Denominator: Positive )
    return Rational is
    begin
        if Numerator = 0 then
            return (0,1);
        else
            declare
                H: Positive := gcd( abs Numerator, Denominator );
            begin
                return (Numerator/H, Denominator/H);
            end;
        end if;
    end;

    procedure Print(r : Rational) is
    begin
        Ada.Text_IO.Put_Line(r.Numerator'Img & "/" & r.Denominator'Image);
    end Print;

    function "/" ( Numerator: Integer; Denominator: Positive ) return Rational is
    begin
        return Normalize( Numerator, Denominator );
    end;

    function "/" ( X, Y: Rational ) return Rational is
    begin
        return Normalize( X.Numerator * Y.Denominator,  X.Denominator * Y.Numerator );
    end;

    function "/" ( X: Rational; Y: Positive ) return Rational is
    begin
        return Normalize( X.Numerator,  X.Denominator * Y );
    end;

    function "+" ( X, Y: Rational) return Rational is
        commonDiviser : Positive;
    begin
        commonDiviser := lcm(x.Denominator, y.Denominator);
        return Normalize(commonDiviser/x.Denominator * x.Numerator + commonDiviser/y.Denominator * y.Numerator, commonDiviser);
    end;

    function "+" (X: Rational; Y: Positive) return Rational is
    begin
        return Normalize(Y*X.Denominator + X.Numerator, X.Denominator);
    end;

    function "*" ( X, Y: Rational) return Rational is
    begin
        return Normalize( X.Numerator * X.Denominator,  Y.Denominator * Y.Numerator );
    end;

    function "*" (X: Rational; Y: Positive) return Rational is
    begin
        return Normalize( X.Numerator * Y,  X.Denominator );
    end;

end Setq;