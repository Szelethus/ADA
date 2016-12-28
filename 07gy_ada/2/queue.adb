package body Queue is

	function Get_Value(Q : in Queues; I : Natural) return Elem is
	begin
		return Q.T(Q.CurrentSize - I + 1);
	end Get_Value;
	
	function Get_Top(Q : Queues) return Elem is
	begin
		return Q.T(Q.CurrentSize);
	end Get_Top;

	procedure Push_Front(Q : in out Queues; E : Elem) is
	begin
		Q.T(Q.CurrentSize + 1) := E;
		Q.CurrentSize := Q.CurrentSize + 1;
	end Push_Front;
	
	procedure Pop_Front(Q : in out Queues) is
	begin
		Q.CurrentSize := Q.CurrentSize - 1;
	end Pop_Front;
	
	function Is_Full(Q : Queues) return Boolean is
	begin
		return Q.CurrentSize = Q.T'Length;
	end Is_Full;
	
	function Is_Empty(Q : Queues) return Boolean is
	begin
		return Q.CurrentSize /= Q.T'Length;
	end Is_Empty;
	
end Queue;