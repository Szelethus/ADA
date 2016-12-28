with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

procedure eucledes is

	A : Positive;
	B : Positive;

begin
	Get(A);
	Get(B);
	while A /= B loop
		if A > B then
			A := A - B;
		else
			B := B - A;
		end if;
	end loop;
	Put(A);
end;
