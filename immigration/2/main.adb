with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

procedure main is
	protected Randomizer is
      entry Randomize(output: out Duration);
      procedure Init;
   private
      RandFloat : Generator;
      initialized : Boolean := False;
   end Randomizer;

   protected body Randomizer is
      entry Randomize(output: out Duration) when initialized is
      begin
         output := Duration(Random(RandFloat));
      end Randomize;

      procedure Init is
      begin
         Reset(RandFloat);
         initialized := True;
      end Init;
   end Randomizer;

    protected Printer is	
		procedure Print( s: in STRING := "" );
	end Printer;

	protected body Printer is
        procedure Print( s: in STRING := "" ) is
		begin
			Put_Line(s);
		end Print;
	end Printer;

	task Freshman;

	task Immigration is
		entry apply;
	end;

	task body Immigration is
		Is_Open : Boolean := False;
		waititme : Duration;
	begin
		Randomizer.Randomize(waititme);
		Printer.Print("Gonna open in " & waititme'img);
		delay waititme;
		select
			accept apply do
				Printer.Print("IMMIGRATION: freshman gets his residense");
			end apply;
		or
			terminate;
		end select;
	end;

	task body Freshman is
	begin
		select
			Immigration.apply;
			Printer.Print("Freshman: got his residence");
		or
			delay 0.5;
			Printer.Print("Freshman: didn't get his residence");
		end select;
	end;
begin
	Randomizer.Init;
end;