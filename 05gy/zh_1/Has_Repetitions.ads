generic
	type Elem is private;
	type Index is (<>);
	type Vector is array(Index range <>) of Elem;

function Has_Repetitions (V : in Vector) return Boolean;