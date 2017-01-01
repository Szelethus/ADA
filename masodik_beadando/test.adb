with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Calendar;
use Ada.Calendar;

procedure Main is

	type Lamp_Color is (Red, Orange, Green, Yellow);
	type String_Access is access String;
	type Duration_Access is access Duration;
	
	protected Lamp is
		procedure Switch;
		function Color return Lamp_Color;
	private
		Current_Color : Lamp_Color := Red;
	end Lamp;
	
	protected body Lamp is
	
		procedure Switch is
			--SA : Signal_Access;
		begin
			if Current_Color = Yellow then
				Current_Color := Red;
			else
				Current_Color := Lamp_Color'Succ(Current_Color);
			end if;
		Put_Line("A lampa aktualis szine " & Lamp_Color'Image(Current_Color));
		end Switch;
		
		function Color return Lamp_Color is
		begin
			return Current_Color;
		end Color;

	end Lamp;

	task Controller is
		entry Stop;
	end Controller;
	
	task body Controller is
		
		function Wait_Time(Color : Lamp_Color) return Duration is
			Ret : Duration;
		begin
			case Color is
				when Red => Ret := Duration(3.0);
				when Orange => Ret := Duration(1.0);
				when Green => Ret := Duration(3.0);
				when Yellow => Ret := Duration(2.0);
			end case;
			
			return Ret;
		end Wait_Time;
		
		Stopped : Boolean := False; 
		
	begin
		while not Stopped loop
			select
				accept Stop do
					Stopped := True;
				end Stop;
			or
				delay Wait_Time(Lamp.Color);
				Lamp.Switch;
			end select;
		end loop;
	end Controller;
	
begin
	Skip_Line;
	Controller.Stop;
end Main;