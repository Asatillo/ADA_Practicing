with Setq, Ada.Integer_Text_IO, Ada.Text_IO;
use Setq, Ada.Integer_Text_IO, Ada.Text_IO;

procedure demo is

    R: Rational := 4/8;
    -- X: Rational := 3/4/5;
    half : Rational := 1/2;
    quarter : Rational := 1/4;

begin

    R := R/(R/2);
    --  Print(R);

    --  half := half + quarter;
    --  half := half + 1;
    

    half := half * 4;
    Print(half);

end demo;