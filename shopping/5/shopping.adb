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
    
    protected Manager is 
        procedure newCustomer;
        procedure getTotal;
    private
        total_customer : Positive;
    end Manager;

    protected body Manager is
        procedure newCustomer is
        begin
            total_customer := total_customer + 1;
        end;

        procedure getTotal is
        begin
            Safe_Print.Print("Total number of customers: " & total_customer'img);
        end;
    end;

    task type Sport is
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
        while is_open and items_sold <= 2 loop
            delay 0.1;
            select
                accept go_in do
                    Safe_Print.Print("SPORT: Hello Customer!");
                    delay 0.1;
                    items_sold := items_sold + 1;
                    Manager.newCustomer;
                end go_in;
            or
                accept close_shop do
                    is_open := False;
                    Safe_Print.Print("SPORT: We are closing with " & items_sold'img & " items sold");   
                end close_shop; 
            end select;
        end loop;
    end;

    task type Shoes is
        entry go_in;
        entry close_shop;
    end;
    task body Shoes is
        is_open : Boolean := False;
        items_sold: Integer := 0;
    begin
        Reset(G);
        delay Duration(Float(Random(G) rem 3)/10.0);
        Safe_Print.Print("SHOES: We are open");
        is_open := true;
        while is_open and items_sold <= 2 loop
            delay 0.1;
            select
                accept go_in do
                    Safe_Print.Print("SHOES: Hello Customer!");
                    delay 0.1;
                    items_sold := items_sold + 1;
                    Manager.newCustomer;
                end go_in;
            or
                accept close_shop do
                    is_open := False;
                    Safe_Print.Print("SHOES: We are closing with " & items_sold'img & " items sold");   
                end close_shop; 
            end select;
        end loop;
    end;

    task type Electronics is
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
        while is_open  and items_sold <= 2 loop
            delay 0.1;
            select
                accept go_in do
                    Safe_Print.Print("ELECTRONICS: Hello Customer!");
                    delay 0.1;
                    items_sold := items_sold + 1;
                    Manager.newCustomer;
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

    type PShoes is access Shoes;
    type PSport is access Sport;
    type PElectronics is access Electronics;

    ShoesShops : array(1..2) of PShoes;
    SportShops : array(1..2) of PSport;
    ElectronicsShops : array(1..2) of PElectronics;

    task type customer(name: PString);
    task body customer is
        rand1 : Positive;
        rand2 : Positive;
        rand3 : Positive;
    begin
        Reset(G);
        rand1 := Random(G) mod 2 + 1;
        Reset(G);
        rand2 := Random(G) mod 2 + 1;
        Reset(G);
        rand3 := Random(G) mod 2 + 1;

        delay 0.9;
        Safe_Print.Print("Customer "& name.all &": I arrived");
        select
            SportShops(rand1).go_in;
            Safe_Print.Print("Customer "& name.all &": I am at sports " & rand1'img);
        or
            delay 0.1;
            Safe_Print.Print("Customer "& name.all &": I waited too long for sports " & rand1'img);
        end select;

        select
            ShoesShops(rand2).go_in;
            Safe_Print.Print("Customer "& name.all &": I am at shoes " & rand2'img);
        or
            delay 0.1;
            Safe_Print.Print("Customer "& name.all &": I waited too long for shoes "  & rand2'img);
        end select;

        select
            ElectronicsShops(rand3).go_in;
            Safe_Print.Print("Customer "& name.all &": I am at electronics " & rand3'img);
        or
            delay 0.3;
            Safe_Print.Print("Customer "& name.all &": I waited too long for electronics " & rand3'img);
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
    for i in 1..2 loop
        ShoesShops(i) := new Shoes;
        delay 0.2;
    end loop;
    for i in 1..2 loop
        SportShops(i) := new Sport;
        delay 0.2;
    end loop;
    for i in 1..2 loop
        ElectronicsShops(i) := new Electronics;
        delay 0.2;
    end loop;
    delay 3.0;

    for i in 1..2 loop
        ShoesShops(i).close_shop;
        SportShops(i).close_shop;
        ElectronicsShops(i).close_shop;
    end loop;

    Manager.getTotal;
end;