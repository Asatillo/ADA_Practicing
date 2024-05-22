with Ada.Text_IO; use Ada.Text_IO;
--  with Ada.Numerics; use Ada.Numerics;

with Ada.Numerics.Elementary_Functions;
use  Ada.Numerics.Elementary_Functions;

package body utility is

    function addTwo (a : Integer; b : Integer) return Integer is

    begin
        return a + b;
    end addTwo;

    function addDigits (Num : in out Integer) return Integer is
        Sum : Integer := 0;
    begin
        while Num > 0 loop
            Sum := Sum + (Num mod 10);
            Num := Num / 10;
        end loop;

        return Sum;
    end addDigits;

    function getSumOfDivisors (Num : Integer) return Integer is
        Sum : Integer := 0;
    begin
        for I in 1 .. Num/2 loop
            if(Num mod I = 0) then
                Sum := Sum + I;
            end if;
        end loop;
        return Sum;
    end getSumOfDivisors;

    function isPalindrome(Num : Integer) return Boolean is
        sum : Integer := 0;
        b, temp : Integer;
    begin
        temp := Num;
        while temp > 0 loop
            b:=temp mod 10;
            sum := sum*10 + b;
            temp := temp/10;
        end loop;
        return sum = Num;
    end isPalindrome;

    function computePower(x, n : Positive) return Positive is
        
    begin
        if n = 1 then
            return x;
        else
            return x * computePower(x, n-1);
        end if;
    end computePower;

    function computeFactorial(n: Positive) return Integer is
    begin
        if n = 1 or n = 0 then
            return 1;
        else
            return n * computeFactorial(n-1);
        end if;
    end computeFactorial;
end utility;
