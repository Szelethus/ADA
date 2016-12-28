with Ada.Text_IO;
with Less_Than;
procedure Less_Than_demo is
	type Grid is array (Natural range <>, Natural range <>) of Natural;
	function LessThan is new Less_Than(Grid);
	
	G : Grid(1..10, 1..10) := (others=>(others=>0));
begin
	G(1,1) := 3;
	if LessThan(G, 0) then
		Ada.Text_IO.Put_Line("Tobb van!");
	else
		Ada.Text_IO.Put_Line("Nincs tobb!");
	end if;
end Less_Than_demo;