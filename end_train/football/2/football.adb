with Ada.Text_IO;
use Ada.Text_IO;

procedure football is
    protected Printer is
        procedure Print(str: String := "");
    end;
    task Goalkeeper;
    task Gate is
        entry Shoot;
        entry Keeper(ready: Boolean);
    end Gate;
    task Player;


    protected body Printer is
        procedure Print(str: String := "") is
        begin
            Put_Line(str);
        end;
    end Printer;
    
    task body Gate is 
        isReady : Boolean := False;
    begin
        loop
            select
                when isReady =>
                    accept Shoot do
                        Printer.Print("GATE: Player shoot");
                    end;
            or
                accept Keeper(ready: Boolean) do
                    if ready then
                        Printer.Print("GATE: Goalkeeper ready!");
                    else
                        Printer.Print("GATE: GoalKeeper is not ready");
                    end if;
                    isReady := ready;
                end;
            or
                terminate;
            end select;
        end loop;
    end;

    
    task body Goalkeeper is
    begin
            Gate.Keeper(True);
            delay 5.0;
            Gate.Keeper(False);
            Printer.Print("GOALKEEPER: I am done");
    end Goalkeeper;

    task body Player is
        scored : Boolean := False;
    begin
        delay 1.0;
        while not scored loop
            select
                Gate.Shoot;
                Printer.Print("PLAYER: I shot");
                scored := true;
            or
                delay 1.0;
            end select;
        end loop;
        Printer.Print("PLAYER: I scored and terminating happily");
    end;
begin
    null;
end;