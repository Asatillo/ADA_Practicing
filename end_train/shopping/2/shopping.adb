with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

procedure shopping is

    protected Safe_Print is
        procedure Print(str : String := "");
    end;

    protected body Safe_Print is
        procedure Print(str : String := "") is
        begin
            Put_Line(str);
        end;
    end;

    protected Safe_rand is
        function Generate return Duration;
        procedure Init;
    private
        GR : Generator;
    end;

    protected body Safe_rand is
        procedure Init is
        begin
            Reset(GR);
        end;

        function Generate return Duration is
        begin
            return Duration(Integer(Random(GR)) mod 3);
        end;
    end;

    task Sport is
        entry go_in;
        entry close_shop;
    end;
    task body Sport is
        is_open : Boolean := False;
        is_visited : Boolean := False;
        --  rand_num : Duration := ;
    begin
        delay Safe_rand.Generate;
        Safe_Print.Print("SPORT: We are open");
        is_open := true;
        while is_open and not is_visited loop
            delay 0.1;
            select
                accept go_in do
                    Safe_Print.Print("SPORT: Hello John!");
                    is_visited := true;
                    delay 0.1;
                end go_in;
            or
                accept close_shop do
                    is_open := False;
                    Safe_Print.Print("SPORT: We are closing");   
                end close_shop; 
            end select;
        end loop;
    end;

    task Shoes is
        entry go_in;
        entry close_shop;
    end;
    task body Shoes is
        is_open : Boolean := False;
        is_visited : Boolean := False;
    begin
        delay Safe_rand.Generate;
        Safe_Print.Print("SHOES: We are open");
        is_open := true;
        while is_open and not is_visited loop
            delay 0.1;
            select
                accept go_in do
                    Safe_Print.Print("SHOES: Hello John!");
                    is_visited := true;
                    delay 0.1;
                end go_in;
            or
                accept close_shop do
                    is_open := False;
                    Safe_Print.Print("SHOES: We are closing");   
                end close_shop; 
            end select;
        end loop;
    end;

    task Electronics is
        entry go_in;
        entry close_shop;
    end;
    task body Electronics is
        is_open : Boolean := False;
        is_visited : Boolean := False;
    begin
        delay Safe_rand.Generate;
        Safe_Print.Print("ELECTRONICS: We are open");
        is_open := true;
        while is_open and not is_visited loop
            delay 0.1;
            select
                accept go_in do
                    Safe_Print.Print("ELECTRONICS: Hello John!");
                    is_visited := true;
                    delay 0.1;
                end go_in;
            or
                accept close_shop do
                    is_open := False;
                    Safe_Print.Print("ELECTRONICS: We are closing");   
                end close_shop; 
            end select;
        end loop;
    end;

    task John;
    task body John is
    begin
        Safe_rand.Init;
        delay 0.1;
        Safe_Print.Print("JOHN: I arrived");
        select
            Sport.go_in;
            Safe_Print.Print("JOHN: I am at sports");
        or
            delay 0.1;
            Safe_Print.Print("JOHN: I waited too long for sports");
        end select;
        select
            Shoes.go_in;
            Safe_Print.Print("JOHN: I am at shoes");
        or
            delay 0.1;
            Safe_Print.Print("JOHN: I waited too long for shoes");
        end select;
        select
            Electronics.go_in;
            Safe_Print.Print("JOHN: I am at electronics");
        or
            delay 0.3;
            Safe_Print.Print("JOHN: I waited too long for electronics");
        end select;
        Sport.close_shop;
        Shoes.close_shop;
        Electronics.close_shop;
    end;
begin
    null;
end;