--with Ada.Text_IO;
--use Ada.Text_IO;
with Linear_Search;

package body Maps is

	procedure Insert (M : in out Map; NewKey : Key; NewValue : Value) is
	
		function Same (I : Pair) return Boolean is
		begin
			return I.K = NewKey;
		end Same;
		
		procedure Is_Same is new Linear_Search(Pair, Natural, PairArray, Same);
		
		B : Boolean := false;
		Ind : Natural;
		
	begin
		if M.CurrentSize = M.Pairs'Length then
			raise Map_Error;
		end if;
		Is_Same(M.Pairs, B, Ind);
		if B then
			M.Pairs(Ind).V := NewValue;
			return;
		end if;
		M.CurrentSize := M.CurrentSize + 1;
		M.Pairs(M.CurrentSize).K := NewKey;
		M.Pairs(M.CurrentSize).V := NewValue;
	end Insert;
	
	procedure Get (M : in out Map; NewKey : Key; NewValue : out Value; B : out Boolean) is
		
	
		function Same (I : Pair) return Boolean is
		begin
			return I.K = NewKey;
		end Same;
		
		procedure Is_Same is new Linear_Search(Pair, Natural, PairArray, Same);
		
		Ind : Natural;
		
	begin
		Is_Same(M.Pairs, B, Ind);
		if B then
			NewValue := M.Pairs(Ind).V;
		end if;
	end;
	
	function Size (M : in Map) return Natural is
	begin
		return M.CurrentSize;
	end Size;
	
	procedure For_Each(M : in out Map) is
	begin
		for I in M.Pairs'Range loop
			Action(M.Pairs(I).K, M.Pairs(I).V);
		end loop;
	end For_Each;

	
end Maps;