function Count_Value (G : Grid) return Natural is
	C : Natural := 0;
begin
	for I in G'Range(1) loop
		for J in G'Range(2) loop
			if Predicate(G(I,J)) then
				C := C + 1;
			end if;
		end loop;
	end loop;
	return C;
end Count_Value;