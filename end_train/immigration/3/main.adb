with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

procedure main is
    protected Randomizer is
        entry Randomize (output : out Duration);
        procedure Init;
    private
        RandFloat   : Generator;
        initialized : Boolean := False;
    end Randomizer;

    protected body Randomizer is
        entry Randomize (output : out Duration) when initialized is
        begin
            output := Duration (Random (RandFloat));
        end Randomize;

        procedure Init is
        begin
            Reset (RandFloat);
            initialized := True;
        end Init;
    end Randomizer;

    type Priority is range 0 .. 2;
    package RandomPriority is new Ada.Numerics.Discrete_Random (Priority);
    use RandomPriority;

    protected PriorityRandomizer is
        entry Randomize (output : out Priority);
        procedure Init;
	private
		RandPriority : RandomPriority.Generator;
		initialized : Boolean := False;
    end PriorityRandomizer;

	protected body PriorityRandomizer is
		entry Randomize (output : out Priority) when initialized is
		begin
			output := Random(RandPriority);
		end Randomize;
		procedure Init is
		begin
			Reset(RandPriority);
			initialized := true;
		end;
	end PriorityRandomizer;

    protected Printer is
        procedure Print (s : in String := "");
    end Printer;

    protected body Printer is
        procedure Print (s : in String := "") is
        begin
            Put_Line (s);
        end Print;
    end Printer;

    type PtrString is access String;
    task type Freshman (id : PtrString);
    type PtrFreshman is access Freshman;

    task Immigration is
        entry apply;
    end Immigration;

    task body Immigration is
        Is_Open  : Boolean := False;
        waititme : Duration;
    begin
        Randomizer.Randomize (waititme);
        Printer.Print ("Gonna open in " & waititme'Img);
        delay waititme;
		loop
			select
				accept apply do
					delay 1.0;
				end apply;
			or
				terminate;
			end select;
		end loop;
    end Immigration;

    task body Freshman is
		priorityVal : Priority;
		delayTime : Duration;

    begin
		PriorityRandomizer.Randomize(priorityVal);
		loop
			exit when priorityVal = 0;
			Printer.Print(id.all & " has priority " & priorityVal'img);
			
			Randomizer.Randomize (delayTime);
			select
				Immigration.apply;
				Printer.Print (id.all & ": got residence permit");
				exit;
			or
				delay delayTime;
				if priorityVal = 1 then
					Printer.Print(id.all & "couldn't get the residence");
				else
					Printer.Print(id.all & "will try again later");
				end if;
				Printer.Print
				(id.all & " didn't get his residence");
			end select;
			
			priorityVal := priorityVal - 1;
		end loop;
    end Freshman;
    freshmans : array (1 .. 21) of PtrFreshman;
begin
    Randomizer.Init;
	PriorityRandomizer.Init;
    for i in freshmans'Range loop
        freshmans (i) := new Freshman (new String'(i'Img));
        delay 0.5;
    end loop;
end main;
