with Ada.Text_IO, Ada.Calendar;
use Ada.Text_IO, Ada.Calendar;

procedure trick is
    protected smth is 
        entry enter;
    private
        startTime : Time := Clock;
    end smth;

    protected body smth is
        --  3 sec pause 1 sec accept
        entry enter when Integer(Clock - startTime) mod 4 < 1 is 
        begin
            Put_Line("I am accepted");
        end enter;
    end smth;

    task taskA;
    task body taskA is 
    begin
        loop
            Put_Line("TaskA is trying to call");
            select
                smth.enter;
            or
                delay 0.0;
            end select;
        end loop;
    end taskA;
begin
    Put_Line("Main started");
end;