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
        function GenerateRandomDoor return Positive;
    private
        GN : rand_int.Generator;
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

        function GenerateRandomDoor return Positive is
        begin
            return Random(GN) mod 6;
        end;
    end;

    task type Door(id: Integer) is
        entry Open;
        entry Close;
        entry Set_Trap;
    end;
    type PtrDoor is access Door;

    type doors_array is array (1..5) of PtrDoor;
    protected Home is
        procedure Init;
        procedure Get_Door(random_door: out PtrDoor);
        procedure Get_Door(id: Positive; random_door: out PtrDoor);
    private
        doors : doors_array;
    end;

    protected body Home is 
        procedure Init is
        begin
            for i in doors'Range loop
                doors(i) := new Door(i);
            end loop;
        end;

        procedure Get_Door(random_door: out PtrDoor) is
        begin
            random_door := doors(Random_Delay.GenerateRandomDoor);
        end;

        procedure Get_Door(id: Positive; random_door: out PtrDoor) is
        begin
            random_door := doors(id);
        end;
    end;

    task Burglar is
        entry Hit;
    end;

    task Kevin is
        entry Catch;
    end;

    task body Kevin is
        rand_door : PtrDoor;
    begin
        for i in 1..5 loop
            rand_door := Home.Get_Door(i, rand_door);
            rand_door.Set_Trap;
            delay 1.0;
            accept Catch do
                Printer.Print("OOOOOh Kevin was caught");
            end Catch;
        end loop;

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
            if is_open then
                accept Set_Trap do
                    trapp := new Trap;
                end;
            end if;
            select
                accept Open do
                    
                    is_open := true;
                    Printer.Print("The door " & id'img & " is open!");
                end;
            or
                accept Close do
                    is_open := false;
                    Printer.Print("The door " & id'img & " is closed!");
                end;
            or
                terminate;
            end select;
        end loop;
    end;

    
    task body Burglar is
        close_door_time : Time;
        rand_door : PtrDoor;
        caught : Boolean := False;
    begin
        delay 1.0;
        Home.Get_Door(rand_door); 
        rand_door.Open;
        close_door_time := Clock + Duration(3.0);
        Printer.Print("I opened the door and gonna wait");
        while close_door_time > Clock and not caught loop
            select
                accept Hit do
                    Printer.Print("OOOh I got hit by a trap");
                    caught := True;
                end Hit;
            end select;
        end loop;
        if not caught then
            Kevin.Catch;
            Printer.Print("Burglar caught Kevin");
        end if;
        rand_door.Close;
        Printer.Print("I am leaving");
    end;

begin
    Random_Delay.Init;
    Home.Init;
end;