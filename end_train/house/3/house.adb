with Ada.Text_IO, Ada.Numerics.Discrete_Random, Ada.Calendar;
use Ada.Text_IO, Ada.Calendar;

procedure house is
    package rand_int is new Ada.Numerics.Discrete_Random(Positive);
    use rand_int;

    protected Printer is	
		procedure Print( s: in STRING := "" );
	end Printer;

	protected body Printer is
        procedure Print( s: in STRING := "" ) is
		begin
			Put_Line(s);
		end Print;
	end Printer;

    protected Random_Delay is
        procedure Init;
        function Generate return Duration;
    private
        GN : Generator;
    end;

    protected body Random_Delay is
        procedure Init is
        begin
            Reset(GN);
        end;

        function Generate return Duration is
        begin
            return Duration(Random(GN) mod 5);
        end;
    end;

    task Door is
        entry Open;
        entry Close;
    end;

    task Burglar is
        entry Hit;
    end;

    task type Trap;
    type PtrTrap is access Trap;

    task body Trap is
        rand : Duration;
    begin
        rand := Random_Delay.Generate;
        Printer.Print("TRAP: Waiting for " & rand'img);
        delay rand;
        Burglar.Hit;
    end;
    task body Door is
        is_open : Boolean;
        trapp : PtrTrap;
    begin
        loop
            select
                accept Open do
                    trapp := new Trap;
                    is_open := true;
                    Printer.Print("The door is open!");
                end;
            or
                accept Close do
                    is_open := false;
                    Printer.Print("The door is closed!");
                end;
            or
                terminate;
            end select;
        end loop;
    end;

    
    task body Burglar is
        close_door_time : Time;
    begin
        delay 1.0;
        Door.Open;
        close_door_time := Clock + Duration(3.0);
        Printer.Print("I opened the door and gonna wait");
        while close_door_time > Clock loop
            select
                accept Hit do
                    Printer.Print("OOOh I got hit by a trap");
                end Hit;
            end select;
        end loop;
        Door.Close;
        Printer.Print("I am leaving");
    end;

begin
    Random_Delay.Init;
end;