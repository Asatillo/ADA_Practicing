generic
    type Cell is (<>);
    with function Rule(c: Cell) return Cell;
package Cellular_Automaton_Package is
    type Cellular_Automaton(height, width : Positive) is private;

    procedure Run(C: in out Cellular_Automaton; N: Natural);
    procedure Iterate(C: in out Cellular_Automaton);
    procedure Put(C: Cellular_Automaton);
private
    type BoardType is array(Positive range <>, Positive range <>) of Cell;
    type Cellular_Automaton(height, width : Positive) is record
        board: BoardType(1..height, 1..width) := (others => (others => Cell'First));
    end record;
end Cellular_Automaton_Package;