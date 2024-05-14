with Ada.Text_IO, Ada.Real_Time;
use Ada.Text_IO, Ada.Real_Time;

procedure timer is 
    startTime : Time := Clock;
    timespan : Time_Span := Seconds(3);
    endtime : Time := startTime + timespan;

    varI : Integer := 0;
begin
    loop
        delay until endtime;
        endtime := endtime + timespan;
        varI := varI + 1;
        Put_Line(varI'img);
        exit when varI = 2;
    end loop;
end;