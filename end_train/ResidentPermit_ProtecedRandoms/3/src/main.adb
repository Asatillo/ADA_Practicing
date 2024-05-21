with Ada.Numerics.Float_Random, Ada.Text_IO;
use Ada.Numerics.Float_Random, Ada.Text_IO;

with Ada.Numerics.Discrete_Random;

procedure Main is

   type Priority is new Integer range 0..2;
   package RandomPriorityPackage is new Ada.Numerics.Discrete_Random(Priority);

   protected Randomizer is
      entry RandomizeFloat(output: out Float);
      entry RandomizePriority(output : out Priority);
      procedure Init;
   private
      RandFloat : Generator;
      RandPriority : RandomPriorityPackage.Generator;
      initialized : Boolean := False;
   end Randomizer;

   protected body Randomizer is
      entry RandomizeFloat(output: out Float) when initialized is
      begin
         output := Random(RandFloat);
      end RandomizeFloat;

      entry RandomizePriority(output : out Priority) when initialized is
      begin
         output := RandomPriorityPackage.Random(RandPriority);
      end RandomizePriority;

      procedure Init is
      begin
         Reset(RandFloat);
         RandomPriorityPackage.Reset(RandPriority);
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


   type StringPtr is access String;
   task type Freshman(id : StringPtr);

   task Immigration is
      entry IssueRP;
   end Immigration;

   task body Immigration is
      waitTime : Float;
   begin
      -- If needed within a range,
      -- waitTime := (maxTime - minTime) * Random(RandFloat) + minTime;
      Randomizer.RandomizeFloat(waitTime);
      delay Duration(waitTime);

      loop
         select
            accept IssueRP  do
               delay 1.0;
               --  Printer.Print("Immigration: freshman gets his residence");
            end IssueRP;
         or
            terminate;
         end select;
      end loop;

   end Immigration;


   task body Freshman is
      priorityValue : Priority;
      waitTime : Float;
   begin
      Randomizer.RandomizePriority(priorityValue);
      loop
         exit when priorityValue = 0;
         Printer.Print(id.all&" has priority "&priorityValue'img);


         select
            Immigration.IssueRP;
            Printer.Print(id.all&" got residence permit");
            exit;
         or
            delay 0.5;

            if priorityValue = 2 then
               Printer.Print(id.all&" will try again later");
            else
               Printer.Print(id.all&" couldn't get the residence");
            end if;
         end select;

         priorityValue := priorityValue - 1;

      end loop;

   end Freshman;

   type FreshmanPtr is access Freshman;
   type StudentArray is array(Positive range 1..21) of FreshmanPtr;
   students : StudentArray;

   id : StringPtr;
begin
   Randomizer.Init;
   for I in 1..21 loop
      id := new String'(I'img);
      students(I) := new Freshman(id);
      delay 0.5;
   end loop;

end Main;
