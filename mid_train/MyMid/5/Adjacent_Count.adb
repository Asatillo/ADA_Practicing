with Ada.Text_IO;
use Ada.Text_IO;

function Adjacent_Count(Mat: Matrix; X, Y: Index) return Natural is
    count : Natural := 0;
begin
    for i in Index'Pred(X)..Index'Succ(x) loop
        for j in Index'Pred(Y)..Index'Succ(Y) loop
            if I in Mat'Range(1) and J in Mat'Range(2) then 
                if not(X=i and Y=j) and Predicate(Mat(i, j)) then
                    count := count + 1;
                end if;
            end if;
        end loop;
    end loop;
    return count;
end;