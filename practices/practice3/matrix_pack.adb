with Ada.Text_IO; use Ada.Text_IO;

package body Matrix_pack is

    --  Compute the sum of the elements of the main diagonal of a square matrix
    function computeDiagSum(mat: Matrix) return Elem is
        sum : Elem := 0;
    begin
        for i in mat'Range loop
            sum := sum + mat(i, i);
        end loop;

        return sum;
    end computeDiagSum;

end Matrix_pack;
