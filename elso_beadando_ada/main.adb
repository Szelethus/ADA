with Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with BinaryTrees;
--with IntegerBinaryTrees;
with Sort;
-- use IntegerBinaryTree;

procedure main is

	procedure AddOne(E : in out Integer) is
	begin
		E := E + 1;
	end AddOne;
	
    package IntegerBinaryTrees is new BinaryTrees(Integer, "<"); 
	use IntegerBinaryTrees;
	procedure AddOneBinaryTree is new IntegerBinaryTrees.For_Each(AddOne);
	
	B : IntegerBinaryTrees.BinaryTree(5);
	
	type TmpArray is array(Integer range <>) of Integer;
	procedure IntegerArraySort is new Sort(Integer, Integer, "<", TmpArray);
	
	T : TmpArray(1..5);
	Tmp : Integer;
	
begin
	Ada.Text_IO.Put_Line("Toltse fel a binaris fat elemekkel!");
	for I in 1..5 loop
		Ada.Text_IO.Put(I'Image);
		Ada.Text_IO.Put(". elem: ");
		Ada.Integer_Text_IO.Get(Tmp);
		Insert(B, Tmp);
	end loop;
	
	for I in 1..Size(B) loop
		Ada.Text_IO.Put(Integer'Image(ReturnValue(B, I)));
		Ada.Text_IO.Put(" ");
	end loop;
	
	AddOneBinaryTree(B);
	Ada.Text_IO.Put_Line("");
	Ada.Text_IO.Put_Line("For_Each fuggveny (minden elemhez hozzaad egyet):");
	
	for I in 1..Size(B) loop
		Ada.Text_IO.Put(Integer'Image(ReturnValue(B, I)));
		Ada.Text_IO.Put(" ");
	end loop;
	
	Ada.Text_IO.Put_Line("");
	Ada.Text_IO.Put_Line("");
	Ada.Text_IO.Put_Line("Tesztelje a rendezest! Toltse fel a tomb elemeit:");
	for I in 1..5 loop
		Ada.Text_IO.Put(Integer'Image(I));
		Ada.Text_IO.Put(". elem: ");
		Ada.Integer_Text_IO.Get(Tmp);
		T(I) := Tmp;
	end loop;
	
	Ada.Text_IO.Put_Line("");
	Ada.Text_IO.Put("Eredeti tomb: ");
	for I in 1..T'Length loop
		Ada.Text_IO.Put(Integer'Image(T(I)));
		Ada.Text_IO.Put(" ");
	end loop;
	
	Ada.Text_IO.Put_Line("");
	IntegerArraySort(T);
	
	Ada.Text_IO.Put("Rendezett tomb: ");
	for I in 1..T'Length loop
		Ada.Text_IO.Put(Integer'Image(T(I)));
		Ada.Text_IO.Put(" ");
	end loop;
	
end main;