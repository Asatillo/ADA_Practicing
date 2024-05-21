with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

procedure shopping is
    package Random_Dur is new Ada.Numerics.Discrete_Random(Positive); use Random_Dur;

    G:Generator;

    protected Safe_Print is
        procedure Print(str : String := "");
    end;

    protected body Safe_Print is
        procedure Print(str : String := "") is
        begin
            Put_Line(str);
        end;
    end;
    

    task Sport is
        entry go_in;
        entry close_shop;
    end;
    task body Sport is
        is_open : Boolean := False;
        items_sold: Integer := 0;
    begin
        Reset(G);
        delay Duration(Float(Random(G) rem 3)/10.0);
        Safe_Print.Print("SPORT: We are open");
        is_open := true;
        while is_open loop
            delay 0.1;
            select
                accept go_in do
                    Safe_Print.Print("SPORT: Hello Customer!");
                    --  is_visited := true;
                    delay 0.1;
                    items_sold := items_sold + 1;
                end go_in;
            or
                accept close_shop do
                    is_open := False;
                    Safe_Print.Print("SPORT: We are closing with " & items_sold'img & " items sold");   
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
        --  is_visited : Boolean := False;
        items_sold: Integer := 0;
    begin
        Reset(G);
        delay Duration(Float(Random(G) rem 3)/10.0);
        Safe_Print.Print("SHOES: We are open");
        is_open := true;
        while is_open loop
            delay 0.1;
            select
                accept go_in do
                    Safe_Print.Print("SHOES: Hello Customer!");
                    --  is_visited := true;
                    delay 0.1;
                    items_sold := items_sold + 1;
                end go_in;
            or
                accept close_shop do
                    is_open := False;
                    Safe_Print.Print("SHOES: We are closing with " & items_sold'img & " items sold");   
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
        items_sold: Integer := 0;
    begin
        Reset(G);
        delay Duration(Float(Random(G) rem 3)/10.0);
        Safe_Print.Print("ELECTRONICS: We are open");
        is_open := true;
        while is_open loop
            delay 0.1;
            select
                accept go_in do
                    Safe_Print.Print("ELECTRONICS: Hello Customer!");
                    delay 0.1;
                    items_sold := items_sold + 1;
                end go_in;
            or
                accept close_shop do
                    is_open := False;
                    Safe_Print.Print("ELECTRONICS: We are closing with " & items_sold'img & " items sold");   
                end close_shop; 
            end select;
        end loop;
    end;

    type PString is access String;

    task type customer(name: PString);
    task body customer is
    begin
        delay 0.1;
        Safe_Print.Print("Customer "& name.all &": I arrived");
        select
            Sport.go_in;
            Safe_Print.Print("Customer "& name.all &": I am at sports");
        or
            delay 0.1;
            Safe_Print.Print("Customer "& name.all &": I waited too long for sports");
        end select;

        select
            Shoes.go_in;
            Safe_Print.Print("Customer "& name.all &": I am at shoes");
        or
            delay 0.1;
            Safe_Print.Print("Customer "& name.all &": I waited too long for shoes");
        end select;

        select
            Electronics.go_in;
            Safe_Print.Print("Customer "& name.all &": I am at electronics");
        or
            delay 0.3;
            Safe_Print.Print("Customer "& name.all &": I waited too long for electronics");
        end select;
    end;

    a: Customer(new String'("H"));
    b: Customer(new String'("O"));
    c: Customer(new String'("S1"));
    d: Customer(new String'("S2"));
    e: Customer(new String'("S3"));
    f: Customer(new String'("A"));
    h: Customer(new String'("M"));
    i: Customer(new String'("E"));
    ab: Customer(new String'("L"));
    abc: Customer(new String'("D"));
    abcd: Customer(new String'("I"));
    abcde: Customer(new String'("N"));
    abcdef: Customer(new String'("Z"));
    acdc: Customer(new String'("K"));
    ac: Customer(new String'("W"));
begin
    delay 3.0;
    Sport.close_shop;
    Shoes.close_shop;
    Electronics.close_shop;
end;