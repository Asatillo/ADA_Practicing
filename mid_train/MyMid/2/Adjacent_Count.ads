generic
    type Item is private;
    type Index is (<>);
    type Matrix is array(Index range <>, Index range <>) of Item;
    with function Predicate(it: Item) return Boolean;
function Adjacent_Count(Mat: Matrix; X, Y: Index) return Natural;
