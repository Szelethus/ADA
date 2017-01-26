
procedure Linear_Search (T : in Item_Array; B : out Boolean; Ind : out Index) is
begin
	for I in T'Range loop
		if Condition(T(I)) then
			B := true;
			Ind := I;
			return;
		end if;
	end loop;
	B := false;
end Linear_Search;