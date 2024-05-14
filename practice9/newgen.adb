with Ada.Numerics.Float_Random, Ada.Text_IO;
use Ada.Numerics.Float_Random, Ada.Text_IO;

procedure newgen is 
    floatGenerator: Generator;
    result: Float;
    lowerBound: Integer := 10;
    upperBound: Integer := 100;

    randint : Integer;
begin
    Reset(floatGenerator);
    result := Random(floatGenerator);

    randint := Integer(result * Float(upperbound - lowerbound) + Float(lowerbound));
    Put_Line(randint'img);
end newgen;