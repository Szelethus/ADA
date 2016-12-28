with Ada.Text_IO;
use Ada.Text_IO;

procedure Cipo_Demo is

	task Dust is
		entry Left_Shoe_Attempt_Step;
		entry Right_Shoe_Attempt_Step;
	end Dust;
	
	type Shoe_Side is (Left, Right);
	
	task body Dust is
		Dust_Length : constant Integer := 10;
		Front_Shoe : Shoe_Side := Left;
	begin
		for I in 1..Dust_Length loop
			select 
				when Front_Shoe = Left => accept Right_Shoe_Attempt_Step;
					Front_Shoe := Right;
					Put_Line("Right shoe");
				or when Front_Shoe = Right => accept Left_Shoe_Attempt_Step;
					Front_Shoe := Left;
					Put_Line("Left shoe");
			end select;
		end loop;
	end Dust;
	
	task Left_Shoe;
	
	task body Left_Shoe is
	begin
		loop
			Dust.Left_Shoe_Attempt_Step;
		end loop;
	end Left_Shoe;
	
	task Right_Shoe;
	
	task body Right_Shoe is
	begin
		loop
			Dust.Right_Shoe_Attempt_Step;
		end loop;
	end Right_Shoe;

begin
	null;
end Cipo_Demo;