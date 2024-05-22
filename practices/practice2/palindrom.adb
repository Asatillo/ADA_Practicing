with Ada.Text_IO; use Ada.Text_IO;
with utility; use utility;

procedure palindrom is
    num : Integer := 1234321;
begin
    Ada.Text_IO.Put_Line(Boolean'Image(isPalindrome(num)));
end palindrom;