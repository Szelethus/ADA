--with Ada.Text_IO;

package body BinaryTrees is

	procedure Insert( B : in out BinaryTree; E : Elem ) is
	begin
		B.CurrentSize := B.CurrentSize + 1;
		B.Data(B.CurrentSize) := E;
		UpHeap(B);
	end Insert;
	
	function Extract( B : in out BinaryTree ) return Elem is
		Ret : constant Elem := B.Data(1);
	begin
		B.Data(1) := B.Data(B.CurrentSize);
		B.CurrentSize := B.CurrentSize - 1;
		if B.CurrentSize <= 1 then
			return Ret;
		end if;
		
		DownHeap(B);
		
		return Ret;
	end Extract;
	
	function Size( B : in BinaryTree ) return Integer is
	begin
		return B.CurrentSize;
	end Size;
	
	function ReturnValue( B : in out BinaryTree; I : Integer ) return Elem is
	begin
		return B.Data(I);
	end ReturnValue;
	
	procedure UpHeap( B : in out BinaryTree ) is
		K : Integer := B.CurrentSize;
		Tmp : Elem;
		Go : Boolean := true;
	begin
		while Go = true and K > 1 loop
		
			if B.Data(K) < B.Data(K / 2) then
				Tmp := B.Data(K);
				B.Data(K) := B.Data(K / 2);
				B.Data(K / 2) := Tmp;
				K := K / 2;
			else
				Go := False;
			end if;
			
		end loop;
	end UpHeap;
	
	procedure DownHeap( B : in out BinaryTree ) is
		K, Smallest : Integer := 1;
		Tmp : Elem;
		Go : Boolean := true;
	begin
		while Go = true loop
			if 2 * K <= B.CurrentSize then
				if B.Data(2 * K) < B.Data(K) then
					Smallest := 2 * K;
				end if;
			end if;
			
			if 2 * K + 1 <= B.CurrentSize then 
				if B.Data(2 * K + 1) < B.Data(Smallest) then
					Smallest := 2 * K + 1;
				end if;
			end if;
			
			if Smallest > K then
				Tmp := B.Data(K);
				B.Data(K) := B.Data(Smallest);
				B.Data(Smallest) := Tmp;
				K := Smallest;
			else
				Go := False;
			end if;
			
		end loop;
	end DownHeap;
	
	
	function "=" (Lhs : BinaryTree; Rhs : BinaryTree) return Boolean is
	begin
		if Lhs.CurrentSize /= Rhs.CurrentSize then
			return false;
		end if;
		for I in 1..Lhs.CurrentSize loop
			if Lhs.Data(I) /= Rhs.Data(I) then
				return false;
			end if;
		end loop;
		return true;
	end;
	
	procedure For_Each (B : in out BinaryTree; UnaryOp : Op) is
	begin
		for I in 1..B.CurrentSize loop
			UnaryOp(B.Data(I));
		end loop;
	end For_Each;
	
end BinaryTrees;