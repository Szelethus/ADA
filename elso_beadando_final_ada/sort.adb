with BinaryTrees;
--with Ada.Text_IO;

procedure Sort (T : in out A_Array) is
	package TmpBinaryTrees is new BinaryTrees(Elem, "<");
	use TmpBinaryTrees;
	Tmp : TmpBinaryTrees.BinaryTree(T'Length);
begin
	for I in T'Range(1) loop
		Insert(Tmp, T(I));
	end loop;
	
	for I in T'Range(1) loop
		T(I) := Extract(Tmp);
	end loop;
end;