with Ada.Text_IO; use Ada.Text_IO;

package body stack_package is

    procedure PushInt (s : in out Stack; elem : Integer) is

    begin
        if s.ptr > s.max then
            Ada.Text_IO.Put_Line ("Stack is full.");
        else
            s.data (s.ptr) := elem;
            s.ptr          := s.ptr + 1;
            Ada.Text_IO.Put_Line (elem'Image & "was pushed.");
        end if;
    end PushInt;

    procedure PopInt (S : in out Stack) is

    begin
        if S.ptr = 1 then
            Ada.Text_IO.Put_Line ("You can't pop anymore!");
        else
            Ada.Text_IO.Put_Line
               (Integer'Image (S.data(S.ptr-1)) & "was popped.");
            S.ptr := S.ptr - 1;
        end if;
    end PopInt;

    procedure Print_Stack(s: Stack) is
    begin
        for i in s.data'First .. s.ptr - 1 loop
            Ada.Text_IO.Put(S.data(i)'Image);
        end loop;
        New_Line;
    end Print_Stack;

end stack_package;
