with Ada.Text_IO, Ada.Calendar;
use Ada.Text_IO, Ada.Calendar;

procedure Elevator_Control is

	type Command_Type is (Forward, Backward);
	
	type Speed_Type is new Integer range -1 .. 1;

	task Motor is
		entry Command(comm : Command_Type);
	end Motor;
	
	
	task body Motor is
		Speed : Speed_Type := 0;
		Distance : Duration := 0.0;
		Time_Forward_Start : Time;
		Time_Backward_Start : Time;
		
	begin
		loop
			select
				accept Command(comm : Command_Type) do
					if comm = Forward then
					
						if Speed = 0 then
							Time_Forward_Start := Clock;
							Speed := 1;
							
						elsif Speed = -1 then
							Distance := Distance - (Clock - Time_Backward_Start);
							Speed := 0;
							
						elsif Speed = 1 then
							Distance := Distance + (Clock - Time_Forward_Start);
							Time_Forward_Start := Clock;
							
						end if;
						--Put_Line("Forward,  distance:" & Duration'Image(Distance) & " speed:" & Speed_Type'Image(Speed));
						
					else -- comm = Backward
					
						if Speed = 0 then
							Time_Backward_Start := Clock;
							Speed := -1;
							
						elsif Speed = 1 then
							Distance := Distance + (Clock - Time_Forward_Start);
							Speed := 0;
							
						elsif Speed = -1 then
							Distance := Distance - (Clock - Time_Backward_Start);
							Time_Backward_Start := Clock;
							
						end if;
						--Put_Line("Backward, distance:" & Duration'Image(Distance) & " speed:" & Speed_Type'Image(Speed));
						
					end if;
				end Command;
			or
				terminate;
				
			end select;
		end loop;
	end Motor;
	
	task Elevator is
		entry Move_Up;
		entry Move_Down;
	end Elevator;
	
	task body Elevator is
		Position : Integer range 0..40 := 0;
	begin
		loop
			select
					when Position /= 40 => accept Move_Up do
						Position := Position + 1;
						Put_Line ("Position changes from" & Integer'Image(Position - 1) & " to" & Integer'Image(Position));
					end Move_Up;
				or
					when Position /= 0  => accept Move_Down do
						Position := Position - 1;
						Put_Line ("Position changes from" & Integer'Image(Position + 1) & " to" & Integer'Image(Position));
					end Move_Down;
				or
					terminate;
			end select;
		end loop;
	end Elevator;
	
begin
	for I in 1..30 loop
		Elevator.Move_Up;
	end loop;
	for I in reverse 1..30 loop
		Elevator.Move_Down;
	end loop;
end Elevator_Control;
