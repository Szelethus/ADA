generic
	type Elem is private;
	
package BinaryTrees is

	generic
		with procedure Op(A: in out Elem);
	procedure For_Each (B : in out BinaryTree);
	
private
	
	type A_Array is array ( Integer range <> ) of Elem;
	type BinaryTree (Size : Integer) is record
		Data : A_Array(1..Size);
		MaxSize : Integer := Size;
		CurrentSize : Integer := 0;
	end record;
	
end BinaryTrees;