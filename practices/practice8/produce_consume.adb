with Ada.Text_IO; use Ada.Text_IO;

procedure produce_consume is
    task producer is 
        entry takeFood;
    end producer;

    task body producer is
        food_made: Natural := 0;
    begin
        loop
            delay 0.15;
            accept takeFood
            do
                food_made := food_made + 1;
                Put_Line("Food Delivered");
            end takeFood;

            exit when food_made = 10;
        end loop;
    end producer;

    task consumer;
    task body consumer is
    begin
        loop
            producer.takeFood;
            Put_Line("Food Gotten");
            exit when not producer'callable;
        end loop;
    end consumer;
begin
    null;
end produce_consume;