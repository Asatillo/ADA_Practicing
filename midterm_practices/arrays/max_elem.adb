function max_elem(arr : ArrayType) return ElemType is
    max : ElemType := arr(arr'First);
begin
    for i in arr'Range loop
        if max < arr(i) then
            max := arr(i);
        end if;
    end loop;
    return max;
end;