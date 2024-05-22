package Matrix_pack is
	
    type Index is new Integer;
    type Elem is new Integer;
    type Matrix is array (Index range <>, Index range <>) of Elem;

    function computeDiagSum(mat: Matrix) return Elem;
end Matrix_pack;