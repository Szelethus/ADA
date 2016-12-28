with Ada.Text_IO, HauntedHouse, Tools;
use Ada.Text_IO, HauntedHouse, Tools;

procedure demo is

	task Princess is
		entry Scare(GhostPos : Position); 
	end Princess;

	task body Princess is
		Pos : Position := (1, 3);
		HealthPoints : Integer := 3;
	begin
		while HealthPoints > 0 and then GetField(pos) /= E loop
			select
				when GetField(Pos) = C => accept Scare(GhostPos : Position) do
					if (GhostPos = Pos) then
						HealthPoints := HealthPoints - 1;
						Output.Puts("Megijedtem! Mar csak" 
									& Integer'Image(HealthPoints)
									&" eletem van.", 1);
					end if;
					end Scare;
			end select;
		end loop;
	end Princess;

	task type Ghost(ID : Integer; Patience : access Duration);
	
	task body Ghost is
		Pos : Position;
	begin
		Output.Puts(Integer'Image(ID) & " szellem feleldt!" , 1);
		while Princess'Callable loop
			Pos := GetRandPos;
			select 
				Princess.Scare(Pos);
			or 
				delay Patience.all;
				Output.Puts("Itt vagyok:("
							& Natural'Image(Pos.X) & "," 
							& Natural'Image(Pos.Y) &")", 1);
			end select;
			delay 0.2;
		end loop;
	end Ghost;
	
	--type GhostArray is array (1..3) of Ghost;
	type GhostPointer is access Ghost;
	
	task type Wizard (GhostCount : Positive; GhostCastTime : access Duration);
	
	task body Wizard is
		IntGhostCount : Integer := Integer(GhostCount);
		GP : GhostPointer;
		ID : Integer := 0;
	begin
		while IntGhostCount > 0  loop
			delay GhostCastTime.all;
			ID := ID + 1;
			GP := new Ghost(ID, new Duration'(Duration(Float(ID) * Float(GhostCastTime.all))));
			IntGhostCount := IntGhostCount - 1;
		end loop;
	end Wizard;
	
	Kartoffel : Wizard(5, new Duration'(0.2));
	--GA : GhostArray;
begin
	null;
end demo;