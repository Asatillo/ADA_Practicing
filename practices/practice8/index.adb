with Ada.Text_IO; use Ada.Text_IO;

procedure index is

    task type PrinterTaskType(Min, Max : Integer);
    type PrinterTaskAccess is access PrinterTaskType;


    task body PrinterTaskType is
    begin
        for I in min..max loop
            Put_Line(I'img);
        end loop;
    end PrinterTaskType;

    type TaskArray is array(Integer range <>) of PrinterTaskAccess;
    MyTasks : TaskArray(1..5);
    
begin
    for i in 0..4 loop
        MyTasks(i+1) := new PrinterTaskType(i*5, (i+1)*5);
    end loop;
end index;