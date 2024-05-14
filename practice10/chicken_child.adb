with Ada.Text_IO, Ada.Calendar, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Calendar, Ada.Numerics.Float_Random;

--  There is a chicken and a little child that needs to feed the chicken, since
--  in the stomach of the chicken the number of seeds are decreasing at every second.
--  If the nr seeds = 0 then the chicken will die. If the child feeds it, it increases
--  the seeds with 3.
--  The child needs to play with the chicken because if it not then will die of sorrow
--  (in this case an exception GONE will be raised).
--  If the chicken consumes 30 seeds, then it will grow up and fly away, and
--  the child will be unhappy. Write all the events of the feeding simulation on the screen.

procedure chicken_child is 

task child;
task chicken is
    entry feed;
    entry play;
end chicken;

GONE : exception;
FLEW : exception;

--  implement
task body chicken is
    seed : Integer := 4;
    seedsConsumed : Integer := 0;
    maxSeed : Integer := 30;
begin
    loop
        if seed <= 0 then
            raise GONE;
        elsif seedsConsumed = 30 then
            raise FLEW;
        else
            select
                accept feed do
                    seed := seed + 3;
                    Put_Line("CHICKEN: I was fed: " & seed'img);
                end;
            or
                accept play do
                    seedsConsumed := seedsConsumed + 1;
                    Put_Line("CHICKEN: I am playing!");
                end;
            or
                delay 1.0;
                seedsConsumed := seedsConsumed + 1;
                Put_Line("CHICKEN: I ate seed!" & seedsConsumed'img);
            end select;
        end if;
    end loop;
exception
    when GONE => 
        Put_Line("CHICKEN: I am gone :-<");
    when FLEW =>
        Put_Line("CHICKEN: I flew!");
end chicken;

task body child is
    G: Generator;
begin
    Reset(G);
    while chicken'Callable loop
            chicken.feed; 
            delay Duration(Random(G) + 2.9);       
    end loop;
    Put_Line("CHILD: I am unhappy!!!");
end child;
    
begin
    null;
end;