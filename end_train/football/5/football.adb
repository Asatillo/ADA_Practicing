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
    task type Player(name: PString; id: Integer);
    type PPlayer is access Player;

    type scoresArray is array (1..4) of Integer;
    protected Scoreboard is
        function Get_Score return Integer;
        procedure Score(id: Integer);
    private
        score_count : Integer := 0;
        scores: scoresArray;
    end;

    task type Ball(name: PString; id: Integer);
    type PBall is access Ball;

--  * The counter's operations waits now also the id of the player calling them. 

--  The players are not calling directly the gate, they are calling via the ball.
--  The `Ball` is task type, which are dynamically created by players.

--  The counter is not a variable, but an array counting the goals scored by a player. 
--  Change the operations accordingly. A player should terminate if at least 4 goals were scored by him.

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
        endTime : Time := Clock + Duration(10.0);
        this_ball : PBall;
    begin
        delay 1.0;
        while clock <= endTime and Scoreboard.Get_Score < 4 loop
            select
                this_ball := new Ball(name, id);
                Scoreboard.Score(this_ball.id);
                Printer.Print("PLAYER " & name.all  & ": I shot");
            or
                delay 1.0;
            end select;
        end loop;
        Printer.Print("PLAYER " & name.all  & ": I scored and terminating happily");
    end;

    protected body Scoreboard is
        function Get_Score return Integer is
        begin
            return score_count;
        end;

        procedure Score(id: Integer) is
        begin
            scores(score_count + 1) := id;
            score_count := score_count + 1;
        end;
            
    end;

    task body Ball is 
    begin
        Printer.Print("BALL " & id'img & ": I was kicked"); 
        Gate.Shoot;;
    end;

    p : PPlayer;
begin
    Printer.Print("OK");
    Safe_Random.Init;
    p := new Player(new String'("Asat"), 1);
    delay 1.0;
    p := new Player(new String'("Rus"), 2);
end;