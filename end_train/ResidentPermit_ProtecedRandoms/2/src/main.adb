with Ada.Numerics.Float_Random, Ada.Text_IO;
use Ada.Numerics.Float_Random, Ada.Text_IO;

procedure Main is
   protected Randomizer is
      entry Randomize(output: out Float);
      procedure Init;
   private
      RandFloat : Generator;
      initialized : Boolean := False;
   end Randomizer;

   protected body Randomizer is
      entry Randomize(output: out Float) when initialized is
      begin
         output := Random(RandFloat);
      end Randomize;

      procedure Init is
      begin
         Reset(RandFloat);
         initialized := True;
      end Init;
   end Randomizer;


   protected Printer is
      procedure Print(S: String);

   end Printer;

   protected body Printer is
      procedure Print(S: String) is
      begin
         Put_Line(S);
      end Print;

   end Printer;


   task Freshman;

   task Immigration is
      entry IssueRP;
   end Immigration;

   task body Immigration is
      waitTime : Float;
   begin
      -- If needed within a range, 
      -- waitTime := (maxTime - minTime) * Random(RandFloat) + minTime;
      Randomizer.Randomize(waitTime);
      Printer.Print(waitTime'img);
      delay Duration(waitTime);
      select
         accept IssueRP  do
            Printer.Print("Immigration: freshman gets his residence");
         end IssueRP;
      or
         terminate;
      end select;

   end Immigration;




   task body Freshman is
   begin
      select
         Immigration.IssueRP;
         Printer.Print("Freshman: got his residence");
      or
         delay 0.5;
         Printer.Print("Freshman: did not get residence");
      end select;
   end Freshman;

begin
   Randomizer.Init;
end Main;
