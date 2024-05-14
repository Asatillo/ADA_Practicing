with Ada.Text_IO; use Ada.Text_IO;

procedure hello is 
    task Simple_Task;
    task body Simple_Task is 
    begin
        for i in 1..N loop
            Put_Line("Hello");
            delay 0.5;
        end loop;
    end Simple_Task;
begin
    null;
end;