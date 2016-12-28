with Ada.Text_IO;
with Count_Value;
procedure Count_Value_Demo is
	type Grid is array (Integer range <>, Integer range <>) of Natural;
	
	function MoreThanZero (N : Natural) return Boolean is
	begin
		return N > 0;
	end;
	
	function CountValue is new Count_Value(Integer, Natural, Grid, MoreThanZero);
	
	G : Grid(1..10, 1..10) := (others=>(others=>0));
begin
	G(1,1) := 3;
	Ada.Text_IO.Put_Line(Integer'Image(CountValue(G)));
end Count_Value_Demo;