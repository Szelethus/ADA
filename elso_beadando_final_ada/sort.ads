generic
	type Elem is private;
	type Index is (<>);
	with function "<"(A,B : Elem) return Boolean is <>;
	type A_Array is array ( Index range <> ) of Elem;
procedure Sort (T : in out A_Array);
	