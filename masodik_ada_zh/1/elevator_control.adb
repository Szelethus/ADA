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
							Time_Forward_Start  := Clock;
							Speed := 1;
							
						elsif Speed = -1 then
							Distance := Distance - (Clock - Time_Backward_Start);
							Speed := 0;
							
						elsif Speed = 1 then
							Distance := Distance + (Clock - Time_Forward_Start);
							Time_Forward_Start  := Clock;
							
						end if;
						Put_Line("Forward,  distance:" & Duration'Image(Distance) & " speed:" & Speed_Type'Image(Speed));
						
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
					Put_Line("Backward, distance:"     & Duration'Image(Distance) & " speed:" & Speed_Type'Image(Speed));
						
					end if;
				end Command;
			or
				terminate;
			end select;
		end loop;
	end Motor;
	
	
	
begin
	Motor.Command(Forward);
	delay 1.5;
	Motor.Command(Forward);
	delay 0.5;
	Motor.Command(Backward);
	delay 0.7;
	Motor.Command(Backward);
	delay 0.5;
	Motor.Command(Backward);
	delay 2.5;
	Motor.Command(Forward);
	delay 1.0;
	Motor.Command(Forward);
	delay 2.0;
end Elevator_Control;
