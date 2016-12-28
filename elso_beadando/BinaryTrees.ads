generic
	type Elem is private;
	with function "<"(A,B : Elem) return Boolean;
	
package BinaryTrees is

	type BinaryTree(Size : Integer) is limited private;
	
	procedure Insert( B : in out BinaryTree; E : Elem );
	function Extract( B : in out BinaryTree ) return Elem;
	function Size( B : in BinaryTree ) return Integer;
	function ReturnValue( B : in out BinaryTree; I : Integer ) return Elem;
	function "=" (Lhs : BinaryTree; Rhs : BinaryTree) return Boolean;

	generic
		with procedure Op(A: in out Elem);
	procedure For_Each (B : in out BinaryTree);
	
private

	procedure UpHeap( B : in out BinaryTree );
	procedure DownHeap( B : in out BinaryTree );
	
	type A_Array is array ( Integer range <> ) of Elem;
	type BinaryTree (Size : Integer) is record
		Data : A_Array(1..Size);
		MaxSize : Integer := Size;
		CurrentSize : Integer := 0;
	end record;
	
end BinaryTrees;