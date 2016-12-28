with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO;

procedure lab1_3 is
	A: Natural;
	Result: Natural := 0;
begin
	Ada.Text_IO.Put_Line("Adj meg 1 szamot:");
	Get(A);
	for I in 1..A loop
		Result := Result + I;
	end loop;
	Put(Result);
end lab1_3;
