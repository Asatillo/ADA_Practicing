with Ada.Text_IO; use Ada.Text_IO;

procedure walk is
    task Sand is
        entry Left;
        entry Right;
    end Sand;

    task body Sand is
        counter : Natural := 0;

        procedure PrintFoot(str: String) is
        begin
            Put_Line(str);
        end PrintFoot;
    begin
        loop
            counter := counter + 1;
            accept Left do
                PrintFoot("Left Foot");
            end Left;

            accept Right do
                PrintFoot("Right Foot");
            end Right;

            exit when counter >= 5;
        end loop;
    end Sand;

    task LeftShoe;
    task body LeftShoe is
    begin
        loop
            Sand.Left;
            exit when not Sand'Callable;
        end loop;
    end LeftShoe;

    task RightShoe;
    task body RightShoe is
    begin
        loop
            Sand.Right;
            exit when not Sand'Callable;
        end loop;
    end RightShoe;
begin
    null;
end;