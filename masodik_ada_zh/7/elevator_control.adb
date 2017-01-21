with Ada.Text_IO, Ada.Calendar;
use Ada.Text_IO, Ada.Calendar;

procedure Elevator_Control is

	type Command_Type is (Forward, Backward, Power_Off);
	type Speed_Type is new Integer range -1 .. 1;
	type Position_Type is new Integer range 0 .. 40;
	type Level_Type is new Integer range 0 .. 4;
		
	Time_Interval : constant Duration := 0.1;

	task Motor is
		entry Command(comm : Command_Type);
	end Motor;
	
	task Elevator is
		entry Move_Up;
		entry Move_Down;
	end Elevator;
	
	task Controller is
		entry Sensor(Level : Level_Type);
	end Controller;
	
	task type Signal(Level : Level_Type);
	type Signal_Access is access Signal;
	
	task body Motor is
		Speed : Speed_Type := 0;
		Distance : Duration := 0.0;
		Time_Forward_Start : Time;
		Time_Backward_Start : Time;
		
		Is_Stopped : Boolean := false;
		
		Motor_Burned_Out : exception;
		
		procedure Move_Elevator is -- A függvényhívás előtt és után a sebesség nem változik
		begin
			case Speed is
				when 1 => 
					Distance := Distance + Time_Interval;
					select
						Elevator.Move_Up;
					or
						delay Time_Interval;
						raise Motor_Burned_Out;
					end select;
				when -1 => 
					Distance := Distance - Time_Interval;
					select
						Elevator.Move_Down;
					or
						delay Time_Interval;
						raise Motor_Burned_Out;
					end select;
				when others => null;
			end case;
		end Move_Elevator;
		
	begin
		while not Is_Stopped loop
			select
				accept Command(comm : Command_Type) do
					--Put_Line("Sajt");
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
						
					elsif comm = Backward then
					
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
						
					elsif comm = Power_Off then
						Is_Stopped := True;
						Put_Line("Motor power off.");

					end if;
				end Command;
			or
				delay Time_Interval;
				Move_Elevator;
				
			end select;
		end loop;
		exception
			when Motor_Burned_Out => Put_Line("Motor's dead, sadly.");
	end Motor;
	
	task body Signal is
	begin
		Controller.Sensor(Level);
	end Signal;
	
	task body Elevator is
		Position : Position_Type := 0;
		Level : Level_Type := 0;
		SA : Signal_Access;
		
		procedure Check_Level is
		begin
			if Integer(Position) mod 10 = 0 then
				Level := Level_Type(Integer(Position) / 10);
				SA := new Signal(Level);
			end if;
		end Check_Level;
	begin
		loop
			select
					when Position /= 40 => accept Move_Up do
						Position := Position + 1;
						Put_Line ("Position changes to" & Position_Type'Image(Position));
						Check_Level;
					end Move_Up;
				or
					when Position /= 0  => accept Move_Down do
						Position := Position - 1;
						Put_Line ("Position changes to" & Position_Type'Image(Position));
						Check_Level;
					end Move_Down;
				or
					terminate;
			end select;
		end loop;
	end Elevator;
	
	task body Controller is
		Is_On_Top : Boolean := false;
	begin
		Motor.Command(Forward);
		while not Is_On_Top loop
			select
				accept Sensor(Level : Level_Type) do
					Put_Line("Level:" & Level_Type'Image(Level));
					if Level = 4 then
						Put_Line("Motor on top!");
						Is_On_Top := true;
					end if;
				end Sensor;
			or 
				terminate;
			end select;
		end loop;
		Motor.Command(Power_Off);
	end Controller;
	
begin
	delay 5.0;
	Motor.Command(Power_Off);
end Elevator_Control;
