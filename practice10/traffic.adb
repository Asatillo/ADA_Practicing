with Ada.Text_IO;
use Ada.Text_IO;

procedure traffic is
    --  Declaration
    type Colours is (RED, YELLOW, GREEN);

    protected lamp is
        procedure Change;
        function isColour return Colours;
    private
        light : Colours := RED;
    end lamp;

    task Scheduler;

    --  Implementation

    protected body lamp is
        procedure Change is
        begin
            if isColour = RED then
                light := YELLOW;
            elsif isColour = YELLOW then
                light := GREEN;
            elsif isColour = GREEN then
                light := RED;
            end if;
            Put_Line(light'Image);
        end;

        function isColour return Colours is
        begin
            return light;
        end;
    end lamp;

--  A task called scheduler should call the procedure change, then waits 2.0 seconds,
--  change, wait 1.5 seconds, then change again and wait 0.5 seconds.
    task body Scheduler is
        round : Integer := 0;
    begin
        while round < 3 loop
            lamp.Change;
            delay 2.0;
            lamp.Change;
            delay 1.5;
            lamp.Change;
            delay 0.5;
            round := round + 1;
            Put_Line("==========");
        end loop;
    end Scheduler;

begin
    null;
end traffic;