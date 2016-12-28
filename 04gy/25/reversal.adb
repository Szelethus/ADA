procedure Reversal(T: in out TArray;) is
	tmp: Elem;
	i,j : Index;
begin
	i := T'First;
	j := T'Last;
	for K in 1..(T'Length/2) loop
		tmp := T(i);
		T(I) := T(J);
		T(J) := tmp;
		I := Index'Succ(I);
		J := Index'Pred(J);
	end loop;
end Reversal;