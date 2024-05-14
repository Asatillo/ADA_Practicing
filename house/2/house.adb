with Ada.Text_IO;
use Ada.Text_IO;

procedure house is

    protected Printer is	
		procedure Print( s: in STRING := "" );
	end Printer;

	protected body Printer is
        procedure Print( s: in STRING := "" ) is
		begin
			Put_Line(s);
		end Print;
	end Printer;

    task Door is
        entry Open;
        entry Close;
    end;

    task Burglar;
    task body Door is
        is_open : Boolean;
    begin
        loop
            select
                when not is_open =>
                    accept Open do
                        is_open := true;
                        Printer.Print("The door is open!");
                    end;
            or
                when is_open =>
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
    begin
        delay 1.0;
        Door.Open;
        Printer.Print("I opened the door and gonna wait");
        delay 3.0;
        Door.Close;
        Printer.Print("I am leaving");
    end;

begin
    Printer.Print("Start");
end;