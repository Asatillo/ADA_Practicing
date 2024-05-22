with bst_package;
with Ada.Text_IO; use Ada.Text_IO;

procedure main is
    package myTreeP is new bst_package(Integer);
    use myTreeP;

    myIntBSTree : BSTree;
begin
    Insert(3, myIntBSTree);
    Insert(6, myIntBSTree);
    Put_Line(Integer'Image(count_node(myIntBSTree)));
end;