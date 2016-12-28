with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO;

procedure lab1_1 is
	A: Integer;
	B: Integer;
begin
	Ada.Text_IO.Put_Line("Adj meg 2 szamot:");
	Get(A);
	Get(B);
	Ada.Text_IO.Put("A ket szam kozul a ");
	if A > B then
		Put(A);
	else
		Put(B);
	end if;
	Ada.Text_IO.Put_Line(" a nagyobb");
end lab1_1;
