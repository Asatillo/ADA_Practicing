package body bst_package is

    function Make_Tree (A: TArray) return BSTree is
        T : BSTree;
    begin
        for I in A'Range loop
            Insert(A(I), T);
        end loop;
        return T;
    end;

    procedure Insert (E: Elem; T: in out BSTree) is 

    begin
        if T = null then
            T := new Node'(E, null, null);
        else
            if(e < T.d) then
                Insert(E, T.leftT);
            else
                Insert(E, T.rightT);
            end if;
        end if;
    end;

    function count_node (T: BSTree) return Integer is 
        count : Integer := 0;
    begin
        if T = null then
            return 0;
        else
            return 1 + count_node(T.LeftT) + count_node(T.RightT);
        end if;
    end;

    function InOrder (T: BSTree; Arr: in out TArrat; Ind: Positive) return TArray is
        --  myArr : TArray(1..count_node(T));
        --  currIndex : Positive := 1;
    begin
        if T /= null then
            if T.LeftT /= null then
                Arr := InOrder(T.LeftT, Arr, Ind);
            end if;
            Arr(Ind) := T.d;
            Ind := Ind + 1;
            if T.RightT /= null then
                Arr := InOrder(T.RightT, Arr, Ind);
            end if;
        end if;
    end;

end bst_package;