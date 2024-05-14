procedure simple_sync is
    Data1 : Integer := 1;
    Data2 : Integer := 2;
begin
    declare
        task T1;
        task body T1 is
        begin
            Data1 := Data1 + 100;
        end T1;
    begin
        null;
    end;
end;