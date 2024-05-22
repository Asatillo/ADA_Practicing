with gcd;

function lcm ( A, B : Positive ) return Positive is
   X: Positive := A;
   Y: Natural := B;
begin
   return (abs (X * Y)/gcd(X, Y));
end lcm;