function Most_Frequent (V : in Vector) return Elem is
	
	type PositiveArray is array (Index range <>) of Positive;
	
	Multiplicity : PositiveArray(V'Range);
	
	function CountPrevElem( TmpIndex : in Index) return Positive is
		I : Index := TmpIndex;
		Count : Positive := 1;
		E : constant Elem := V(I);
	begin
		I := Index'Pred(I);
		while I >= V'First loop
			if V(I) = E then
				Count := Count + 1;
			end if;
			I := Index'Pred(I);
		end loop;
		return Count;
	end CountPrevElem;
	
	Max : Index := V'First;

begin
	Multiplicity(V'First) := 1;
	for I in V(Index'Succ(V'First))..V'Last loop
		Multiplicity(I) := CountPrevElem(I);
		
		if Multiplicity(Max) < Multiplicity(I) then
			Max := I;
		end if;
	end loop;
	
	return V(Max);
end Most_Frequent;