generic
    type ElemType is private;
    type IndexType is (<>);
    type ArrayType is array(IndexType range <>) of ElemType;

    with function "<"(A,B : ElemType) return Boolean is <>;
    function max_elem(arr : ArrayType) return ElemType;
