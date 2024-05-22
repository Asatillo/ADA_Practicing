--  The generic parameters are:
--  - an index type.
--  - the Grid represented as a matrix of size NxM with the above index and of natural elements.
--  The parameter of the Count function is a Grid, which provides new-born birds in each of the NxM nests (natural values).
--  The function should return the global (sum) number of new birds' population.
--  In a demo use a grid of 10x10, initialize it, and print the above global value.
with Ada.Text_IO; use Ada.Text_IO;
with grid_package;

procedure main is
    package MyGridPackage is new grid_package(T => Integer);
    use MyGridPackage;

    procedure MyCount is new MyGridPackage.Count;

    g: Grid := ((1, 1, 0, 0, 0, 1, 1, 0, 0, 0),
                (1, 1, 0, 0, 0, 1, 1, 0, 0, 0),
                (1, 1, 0, 0, 0, 1, 1, 0, 0, 0),
                (1, 1, 0, 0, 0, 1, 1, 0, 0, 0),
                (1, 1, 0, 0, 0, 1, 1, 0, 0, 0),
                (1, 1, 0, 0, 0, 1, 1, 0, 0, 0),
                (1, 1, 0, 0, 0, 1, 1, 0, 0, 0),
                (1, 1, 0, 0, 0, 1, 1, 0, 0, 0),
                (1, 1, 0, 0, 0, 1, 1, 0, 0, 0),
                (1, 1, 0, 0, 0, 1, 1, 0, 0, 0));

begin
    Ada.Text_IO(Integer'Image(MyCount(g)));
end main;