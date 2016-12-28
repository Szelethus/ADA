generic
	type Elem is private;
	type Index is (<>);
	type TArray is array ( Index range <> ) of Elem;
procedure Reversal(T: in out TArray; I: out Index; E: out Elem);