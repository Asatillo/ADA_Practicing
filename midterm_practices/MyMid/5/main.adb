with Cellular_Automaton_Package;

procedure Main is 
    type Cell is (O, I);
    function Rule(c: Cell) return cell is
    begin
        if c = O then
            return I;
        else
            return O;
        end if;
    end;
    

    package My_Cellular is new Cellular_Automaton_Package(Cell, Rule);
    use My_Cellular;

    C1 : Coordinate := (X => 1, Y => 1, Value => Cell'Last);

    C2 : Coordinate := (X => 2, Y => 3, Value => Cell'Last);

    InCA : CoordinateArray(1..2) := (C1, C2);

    CA : Cellular_Automaton(3, 3);
begin
    Init(InCA, CA);  
    Run(CA, 5);
end;