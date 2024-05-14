generic
    type T is (<>);
    
package grid_package is
    
    type Grid is array(T range <>, T range <>) of Natural;

    generic
        type T;
    function Count(g: Grid) return Natural;
end grid_package;