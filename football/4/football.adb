with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar;
use Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar;

procedure football is

    type PString is access String;

    protected Printer is
        procedure Print(str: String := "");
    end;
    protected Safe_Random is
        procedure Init;
        function Generate return Float;
    private
        G: Generator;
    end Safe_Random;
    task Goalkeeper;
    task Gate is
        entry Shoot;
        entry Keeper(ready: Boolean);
    end Gate;
    task type Player(name: PString);
    type PPlayer is access Player;

    protected Scoreboard is
        function Get_Score return Integer;
        procedure Score;
    private
        scores: Integer := 0;
    end;


    protected body Printer is
        procedure Print(str: String := "") is
        begin
            Put_Line(str);
        end;
    end Printer;

    protected body Safe_Random is
        procedure Init is
        begin
            Reset(g);
        end;
        function Generate return Float is
        begin
            return Random(g);
        end;
    end Safe_Random;
    
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
        rand : Float;
        endGame : Time := Clock + Duration(10.0);
    begin
        while endGame >= Clock loop
            delay 1.5;
            rand := Safe_Random.Generate;
            if rand < 0.7 then
                Gate.Keeper(True);
            else
                Gate.Keeper(False);
            end if;
        end loop;
        Printer.Print("GOALKEEPER: I am done");
    end Goalkeeper;

    task body Player is
        scored : Boolean := False;
        endTime : Time := Clock + Duration(10.0);
    begin
        delay 1.0;
        while clock <= endTime and Scoreboard.Get_Score < 4 loop
            select
                Gate.Shoot;
                Printer.Print("PLAYER " & name.all  & ": I shot");
                Scoreboard.Score;
                scored := true;
            or
                delay 1.0;
            end select;
        end loop;
        Printer.Print("PLAYER: I scored and terminating happily");
    end;

    protected body Scoreboard is
        function Get_Score return Integer is
        begin
            return scores;
        end;

        procedure Score is
        begin
            scores := scores + 1;
        end;
            
    end;

    p : PPlayer;
begin
    Printer.Print("OK");
    Safe_Random.Init;
    p := new Player(new String'("Asat"));
    delay 1.0;
    p := new Player(new String'("Rus"));
end;