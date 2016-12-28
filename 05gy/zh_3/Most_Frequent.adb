function Most_Frequent (V : in Vector) return Elem is

	function Multiplicity(E : Elem) return Natural is
		Count : Natural := 0;
	begin
		for I in V'Range loop
			if V(I) = E then
				Count := Count + 1;
			end if;
		end loop;
		return Count;
	end Multiplicity;
	
	MaxCount : Natural;
	MaxElem : Elem;

begin
	MaxCount := Multiplicity(V(V'First));
	MaxElem := V(V'First);
	for I in Index'Succ(V'First)..V'Last loop
		if Multiplicity(V(I)) > MaxCount then
			MaxCount := Multiplicity(V(I));
			MaxElem := V(I);
		end if;
	end loop;
	return MaxElem;
end Most_Frequent;