with Ada.Text_IO, Ada.Calendar;
use Ada.Text_IO, Ada.Calendar;

procedure Elevator_Control is

	type Command_Type is (Forward, Backward);
	
	type Speed_Type is new Integer range -1 .. 1;

	task Motor is
		entry Command(comm : Command_Type);
	end Motor;
	
	task Elevator is
		entry Move_Up;
		entry Move_Down;
	end Elevator;
	
	task body Motor is
		Speed : Speed_Type := 0;
		Distance : Duration := 0.0;
		Time_Forward_Start : Time;
		Time_Backward_Start : Time;
		
		Time_Interval : constant Duration := 0.1;
		
		procedure Move_Elevator is -- A függvényhívás előtt és után a sebesség nem változik
		begin
			case Speed is
				when 1 => 
					Distance := Distance + Time_Interval;
					Elevator.Move_Up;
				when -1 => 
					Distance := Distance - Time_Interval;
					Elevator.Move_Down;
				when others => null;
			end case;
		end Move_Elevator;
		
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
				delay Time_Interval;
				Move_Elevator;
				
			end select;
		end loop;
	end Motor;
	
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
	delay 1.0;
	Put_Line("Forward");
	Motor.Command(Forward);
	delay 1.5;
	Motor.Command(Forward);
	delay 0.5;
	Put_Line("Stop");
	Motor.Command(Backward);
	delay 0.7;
	Put_Line("Backward");
	Motor.Command(Backward);
	delay 0.5;
	Motor.Command(Backward);
	delay 1.0;
	Put_Line("Stop");
	Motor.Command(Forward);
	delay 1.0;
	Put_Line("Forward");
	Motor.Command(Forward);
	delay 2.0;
	abort Motor;
end Elevator_Control;
