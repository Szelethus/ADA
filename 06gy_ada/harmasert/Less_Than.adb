with Ada.Text_IO;

function Less_Than (G : Grid; Max : Natural) return Boolean is
	Ret : Boolean := false;
	Count : Natural := 0;
begin
	--Ada.Text_IO.Put_Line(Integer'Image(G(1,1)));
	for I in G'Range(1) loop
		for J in G'Range(2) loop
			if G(I,J) /= 0 then
				Count := Count + G(I,J);
			end if;
			Ada.Text_IO.Put_Line(Integer'Image(COunt));
			if Max <= Count then
				return true;
			end if;
		end loop;
	end loop;
	return false;
end Less_Than;