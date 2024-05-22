with Ada.Text_IO;
use Ada.Text_IO;

procedure entries is
    task taskA is
        entry call;
        entry call2;
    end taskA;

    task body taskA is
    begin
        accept call
        do
            Put_Line("I was called");
        end call;

        accept call2
        do
            Put_Line("I am call 2");
        end call2;
    end taskA;

    task callerTask;
    task body callerTask is
    begin
        taskA.call2;
    end callerTask;
begin
    taskA.call;
    --  taskA.call2;
end;