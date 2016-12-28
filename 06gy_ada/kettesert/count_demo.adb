with Ada.Text_IO;
with Count;
procedure Count_Demo is
	type Grid is array (Integer range <>, Integer range <>) of Natural;
	function IntegerCount is new Count(Integer, Grid);
	
	G : Grid(1..10, 1..10) := (others=>(others=>0));
begin
	Ada.Text_IO.Put_Line(Integer'Image(IntegerCount(G)));
end Count_Demo;