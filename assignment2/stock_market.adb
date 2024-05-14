with Ada.Text_IO, Ada.Calendar, Ada.Numerics.Float_Random, Ada.Numerics.Discrete_Random; 
use Ada.Text_IO, Ada.Calendar, Ada.Numerics.Float_Random;

procedure stock_market is

    --  Declarations 
    --  Stock types
    type StockType is (TSLA, NFLX, APPL);

    package Stock_Random is new Ada.Numerics.Discrete_Random(StockType);
    use Stock_Random;

    --  Printer
    protected Printer is	
		procedure Print( s: STRING := "" );
	end Printer;

	--  Rand Stock generator
    protected Safe_Random_Stock is
      procedure Init;
      function Generate return StockType;
    private
      G: Stock_Random.Generator;
    end Safe_Random_Stock;

    --  Rand Float generator
    protected Safe_Float_Random is
        procedure Init;
        function Generate return Float;
        function Generate_Mode return Integer;
    private
        GF : Ada.Numerics.Float_Random.Generator;
    end Safe_Float_Random;
    
    type PriceChart is array(StockType) of Float;

    --  Market
    protected Market is
        procedure InitPrices(newPrices: PriceChart);
        entry PlaceOrder(stock: StockType; mode: Integer);
        procedure Report;
    private
        prices : PriceChart;
        startTime : Time := Clock;
        acceptTime : Integer := 3;
        waitTime : Integer := 1;
    end Market;

    --  Customer
    task type Person is 
        entry Stop;
    end Person;

    --  Pointer to person
    type PersonPtr is access Person;

    --  People
    type People is Array (1..5) of PersonPtr; 
    
    --  Monitor
    task type Monitor;

    --  Implementations
    --  Printer
    protected body Printer is
      procedure Print(S: String := "") is
      begin
         Put_Line(S);
      end;
    end Printer;

    --  Random Stock Generator
    protected body Safe_Random_Stock is
      procedure Init is
      begin
         Reset(G);
      end Init;

      function Generate return StockType is
      begin
         return Random(G);
      end Generate;
   end Safe_Random_Stock;

    --  Random Float Generator
    protected body Safe_Float_Random is
        procedure Init is
        begin
            Reset(GF);
        end Init;

        function Generate return Float is
            Min : Float := 1.5;
            Max : Float := 2.0;
        begin
            return Random(GF) * (Max - Min) + Min;
        end Generate;

        function Generate_Mode return Integer is
        begin
            if Random(GF) > 0.5 then 
                    return 1;
                else
                    return -1;
                end if;
        end Generate_Mode;
    end Safe_Float_Random;

    --  Market
   protected body Market is
        procedure Report is
        begin
            Printer.Print("==== REPORT ====");
            for stock in StockType loop
                Printer.Print("# " & stock'Image & " : " & Float'Image(prices(stock)));
            end loop;
            Printer.Print("================");
        end;

        procedure InitPrices(newPrices: PriceChart) is
        begin
             prices := newPrices;
             Printer.Print("Prices inititlized!");
        end;

        entry PlaceOrder(stock: StockType; mode: Integer) 
            when Integer(Clock - startTime) mod (acceptTime+waitTime) < acceptTime is
        begin
            prices(stock) := prices(stock) + Float(mode) * 0.01;
            if mode = -1 then
                Printer.Print (stock'Img & " went down :(");
            else
                Printer.Print (stock'Img & " went up :)");
            end if;
        end PlaceOrder;
    end Market;

    --  Person
    task body Person is
        randomStock : StockType;
        mode : Integer;
        personDelay : Duration;
        alive : Boolean := True;
    begin        
        while alive loop         
                personDelay := Duration(Safe_Float_Random.Generate);
                --  Printer.Print("PERSON will wait " & personDelay'Img);
                delay personDelay;
                randomStock := Safe_Random_Stock.Generate;

                mode := Safe_Float_Random.Generate_Mode;
                select
                    Market.PlaceOrder(randomStock, mode);
                or
                    delay 0.5;
                end select;

                select
                    accept Stop do
                        alive := FALSE;
                    end Stop;
                else
                    alive := True;
                end select;
        end loop;
    end Person;

    

    task body Monitor is 
        peop: People;
        endTime : Time;
        simStart : Time;
        simEnd: Time;
        myInitialPrice : PriceChart := (4.0, 3.0, 5.0);
        round : Integer := 1; 
    begin
        Market.InitPrices (myInitialPrice);
        delay 0.5;        
        --  Initialize people
        for i in peop'range loop
            peop(i) := new Person;
        end loop;
        Printer.Print("People are ready!");
        simStart := Clock;
        endTime := Clock + Duration(8.0);
        while Clock < endTime loop
            if round <= 2 then
                Market.Report;
                round := round + 1;
                delay 3.5;
            end if;
        end loop;
        simEnd := Clock;
        for i in peop'range loop
            peop(i).Stop;
        end loop;
        Market.Report;
        Printer.Print("Stock market is closed!");
        Printer.Print("Simulation Lasted" & Duration'Image(simEnd - simStart));
    end Monitor;
    
    myMonitor : Monitor;
begin
    Safe_Random_Stock.Init;
    Safe_Float_Random.Init;
end stock_market;