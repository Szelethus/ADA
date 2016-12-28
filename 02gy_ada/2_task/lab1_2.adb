with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO;

procedure lab1_2 is
	A: Integer;
	B: Integer;
	C: Integer;
begin
	Ada.Text_IO.Put_Line("Adj meg 3 szamot:");
	Get(A);
	Get(B);
	Get(C);
	Ada.Text_IO.Put("A ket szam kozul a ");
	if A > B then
		if A > C then
			Put(A);
		elsif C > B then
			Put(C);
		else
			Put(B);
		end if;
	elsif C > B then
		Put(C);
	else
		Put(B);
	end if;
	Ada.Text_IO.Put_Line(" a nagyobb");
end lab1_2;
