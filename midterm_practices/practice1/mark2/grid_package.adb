package body grid_package is

    function Count(g: Grid) return Natural is
        sum: Natural := 0;
    begin
        for i in g'Range loop
            for j in g(i)'Range loop
                sum := sum + g(i)(j);
            end loop;
        end loop;
        return sum;
    end;
end grid_package;