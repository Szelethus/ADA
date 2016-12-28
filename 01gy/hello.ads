with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO;

procedure hello is
	A : Positive;
	B : Positive := 1;

	function Square(N : Integer) return Integer is
	begin
		Put(B);
		return N**2;
	end Square;

begin
	--Get(A);
	if A mod 3 = 0 then
		Ada.Text_IO.Put_Line("Harommal oszthato");
	elsif A mod 3 = 1 then
                Ada.Text_IO.Put_Line("Harommal osztva 1 maradekot ad");
	else
                Ada.Text_IO.Put_Line("Harommal osztva 2 maradekot ad");
	end if;

	for I in Integer range 1..10 loop
		if I mod 2 = 0 then
			Put (Square(I)); --(I**2) == (I * I)
		end if;

		B := B * I;
	end loop;

        Put(B);

end hello;
