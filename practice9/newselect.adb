with Ada.Text_IO;
use Ada.Text_IO;

procedure newselect is
    task SomeTask is 
        entry One;
        entry Two;
    end SomeTask;

    task body SomeTask is
    begin
        select
            accept One do
                Put_Line("One");
            end One;
        or
            accept Two do
                Put_Line("Two");
            end Two;
        end select;
    end SomeTask;
begin
    SomeTask.One;
end;