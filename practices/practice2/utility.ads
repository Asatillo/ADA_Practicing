package utility is
    function addTwo(a: Integer; b: Integer) return Integer;

    function addDigits (Num : in out Integer) return Integer;

    function getSumOfDivisors (Num : Integer) return Integer;

    function isPalindrome(Num : Integer) return Boolean;

    function computePower(x, n : Positive) return Positive;

    function computeFactorial(n: Positive) return Integer;
end utility;