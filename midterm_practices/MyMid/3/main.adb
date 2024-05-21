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

    myCAD : Cellular_Automaton(3, 3);
begin
    Run(myCAD, 5);
end;