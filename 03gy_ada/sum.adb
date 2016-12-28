with Ada.Integer_Text_IO, Ada.Text_IO; 
use Ada.Integer_Text_IO;
with Ada.Text_IO;
use Ada.Text_IO;

procedure sum is
	type Index is new Integer;
	type Element is new Integer;
	type Myarray is array (Index range <>) of Element;
	
	function Summarize( A : Myarray) return Element is
	begin
		if A'Length = 0 then
			return 0;
		else
			return A(A'First) + Summarize(A(Index'Succ(A'First)..A'Last));
		end if;
	end Summarize;
	
	function FindMax(A: Myarray) return Index is
		MaxIndex : Index := A'First;
	begin
		for I in A'Range loop
			if A(MaxIndex) < A(I) then
				MaxIndex := I;
			end if;
		end loop;
		return MaxIndex;
	end FindMax;
	
	procedure Swap (A, B : in out Element) is
		Tmp : Element := A;
	begin
		A := B;
		B := Tmp;
	end Swap;
	
	procedure Order ( T : in out Myarray) is
		MaxIndex : Index;
	begin
		for I in reverse T'Range loop
			MaxIndex := FindMax(T(T'First..I));
			Swap(T(I), T(MaxIndex));
		end loop;
	end Order;
	
begin
	null;
end sum;
