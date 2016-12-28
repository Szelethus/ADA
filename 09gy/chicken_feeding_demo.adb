with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Calendar;
use Ada.Calendar;

procedure Chicken_Feeding_Demo is

	package Random_Boolean_Generator is new Ada.Numerics.Discrete_Random(Boolean);
	use Random_Boolean_Generator;

	task Chicken is
		entry Feed;
		entry Play;
	end Chicken;
	
	task body Chicken is
		Initial_Seed_Count : constant Natural := 4;
		Mature_Chicken_Seed_Count : constant Natural := 30;
		Initial_Played_Seconds : constant Natural := 5;

		Played_Seconds : Natural := Initial_Played_Seconds;
		Seed_Count : Natural := Initial_Seed_Count;
		Is_Dead, Is_Raised : Boolean := false;
		
		MEGPUSZTULOK : exception;
	begin
		while Is_Dead = false and then Is_Raised = false loop
			select
				accept Play;
					Played_Seconds := 5;
					Put_Line("Chicken played with! He is happy for another " & Natural'Image(Played_Seconds) & " seconds.");
				or accept Feed;
					Seed_Count := Seed_Count + 3;
					Put_Line("Chicken fed! He has now " & Natural'Image(Seed_Count) & " seeds in his belly.");
				or delay 1.0;
					Played_Seconds := Played_Seconds - 1;
					Put_Line("Poor chicken is only happy for " & Natural'Image(Played_Seconds) & " more seconds." );
					Seed_Count := Seed_Count - 1;
					Put_Line("Poor chicken's belly only has " & Natural'Image(Seed_Count) & " seeds now");
			end select;
			
			if Played_Seconds = 0 then
				Is_Dead := true;
				Put_Line("Chicken passed away because of unhappyness. No wonder, because he is fat as fuck.");
				raise MEGPUSZTULOK;
			elsif Seed_Count = 0 then
				Is_Dead := true;
				Put_Line("Sadly, chicken passed away because of starvation.");
				raise MEGPUSZTULOK;
			elsif Seed_Count >= 30 then
				Put_Line("Chicken has grown up and flew away!");
				Is_Raised := true;
			end if;
		end loop;
	end Chicken;

	task Girl;
	
	task body Girl is
		G : Generator;
	begin
		Reset(G);
		loop
			if Random(G) then
				Chicken.Feed;
			else
				Chicken.Play;
			end if;
			delay 1.0;
		end loop;
		exception
			when Tasking_Error => Put_Line("The girl shreds a tear.");
	end Girl;

begin
	null;
end Chicken_Feeding_Demo;