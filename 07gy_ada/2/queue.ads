generic
	type Elem is private;
package Queue is

	type Queues(Max : Natural) is private;

	function Get_Value(Q : Queues; I : Natural) return Elem;
	function Get_Top(Q : Queues) return Elem;
	
	procedure Push_Front(Q : in out Queues; E : Elem);
	procedure Pop_Front(Q : in out Queues);
	
	function Is_Full(Q : Queues) return Boolean;
	function Is_Empty(Q : Queues) return Boolean;
	
private
	type Tomb is array (Natural range <>) of Elem;
	type Queues(Max: Natural) is record 
		T : Tomb(1..Max);
		CurrentSize : Natural := 0;
	end record;
	
end Queue;