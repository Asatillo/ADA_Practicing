with Ada.Text_IO;
use Ada.Text_IO;

procedure traffic2 is
    --  Declaration
    type Colours is (RED, YELLOW, GREEN);

    protected lamp is
        entry pass;
        procedure Change;
        function isColour return Colours;
    private
        light : Colours := RED;
    end lamp;

    protected body lamp is
        procedure Change is
        begin
            if light = GREEN then
                light := RED;
            else
                light := Colours'Succ(light);
            end if;
            Put_Line(light'Image);
        end;

        function isColour return Colours is
        begin
            return light;
        end;

        entry pass when light = GREEN is
        begin
            Put_Line("Car has passed");
        end pass;
    end lamp;

    task Scheduler;
    task body Scheduler is
    begin       
        for i in 1..3 loop
            lamp.Change;
            delay 2.0;
            lamp.Change;
            delay 1.5;
            lamp.Change;
            delay 0.5;
            Put_Line("==========");
        end loop;
    end Scheduler;

    type StringP is access STRING;
    type DurationP is access Duration;

    task type Car(plate: StringP; time : DurationP);
    task body Car is
        passed : Boolean := false;
    begin
        delay time.all;
        while not passed loop
            select
                lamp.pass;
                passed := true;
                Put_Line(plate.all & " has passed");
            or
                delay 0.2;
            end select;
        end loop;
    end Car;

    type CarP is access Car;
    my_cars : array (1..3) of CarP;
begin
    my_cars(1) := new Car(new String'("ab-123"), new Duration'(2.0)); 
    my_cars(2) := new Car(new String'("gh-492"), new Duration'(2.5));
    my_cars(3) := new Car(new String'("op-000"), new Duration'(1.3));
end traffic2;