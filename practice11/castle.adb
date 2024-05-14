with Ada.Text_IO;
use Ada.Text_IO;


--  A princess, who has initially the position 1.3 and 3 lives gets easily scared by ghosts.
--  When a princess is scared by a ghost (who is giving to her its position by the entry parameter)
--  it loses one life. The princess should check if the ghost was also on the same position 
--  as hers in order to loose life. When she has no more lives, she dies. 
--  A ghost calls the princess until she is callable (use Task'Callable attribute)
--  then it will have a random position (GetRandPos) and tries to scary the princess. 
--  Between two calls of the princess, it is waiting 0.2 seconds.
procedure castle is

    type map is array(1..3, 1..3) of Integer;
    task type princess;
    task body princess is
        lives : Integer := 3;
    begin
        loop
            select
                
            end select;
        end loop;
    end;
begin
    
end castle;