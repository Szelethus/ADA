function Has_Repetitions (V : in Vector) return Boolean is
begin
	for I in V'First..Index'Pred(V'Last) loop
		if V(I) = V(Index'Succ(I)) then
			return true;
		end if;
	end loop;
	return false;
end Has_Repetitions;