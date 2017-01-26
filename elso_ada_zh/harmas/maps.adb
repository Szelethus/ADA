--with Ada.Text_IO;
--use Ada.Text_IO;

package body Maps is

	procedure Insert (M : in out Map; NewKey : Key; NewValue : Value) is
	begin
		if M.CurrentSize = M.Pairs'Length then
			raise Map_Error;
		end if;
		M.CurrentSize := M.CurrentSize + 1;
		M.Pairs(M.CurrentSize).K := NewKey;
		M.Pairs(M.CurrentSize).V := NewValue;
	end Insert;
	
	procedure Get (M : in out Map; NewKey : Key; NewValue : out Value; B : out Boolean) is
	begin
		for I in M.Pairs'Range loop
			if M.Pairs(I).K = NewKey then
				B := true;
				--Put_Line("Debug!");
				NewValue := M.Pairs(I).V;
				return;
			end if;
		end loop;
		B := false;
	end;
	
end Maps;