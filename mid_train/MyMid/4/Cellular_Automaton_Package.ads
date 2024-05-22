generic
    type Cell is (<>);
    with function Rule(c: Cell) return Cell;
package Cellular_Automaton_Package is
    type Cellular_Automaton(height, width : Positive) is private;
    type Coordinate;
    type Coordinate is record
        X: Positive;
        Y: Positive;
        Value: Cell;
    end record;
    type CoordinateArray is array (Positive range <>) of Coordinate;

    procedure Run(C: in out Cellular_Automaton; N: Natural);
    procedure Iterate(C: in out Cellular_Automaton);
    procedure Put(C: Cellular_Automaton);
    procedure Init ( InCA : in CoordinateArray; OutCA : out Cellular_Automaton );
private
    

    type BoardType is array(Positive range <>, Positive range <>) of Cell;
    type Cellular_Automaton(height, width : Positive) is record
        board: BoardType(1..height, 1..width) := (others => (others => Cell'First));
    end record;
end Cellular_Automaton_Package;