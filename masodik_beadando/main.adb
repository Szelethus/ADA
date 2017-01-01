with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Calendar;
use Ada.Calendar;

procedure Main is

	type Lamp_Color is (Red, Orange, Green, Yellow);
	
	protected Lamp is
		procedure Switch;
		function Color return Lamp_Color;
		
		entry Pass;
	private
		Current_Color : Lamp_Color := Red;
	end Lamp;
	
	protected body Lamp is
	
		procedure Switch is
		begin
			if Current_Color = Green then
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
		
		entry Pass when Current_Color = Green is
		begin
			Put_Line("Athaladt egy auto");
		end Pass;

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
	
	type String_Access is access String;
	type Duration_Access is access Duration;
	
	task type Vehlice (License_Plate_Number : String_Access; Time_To_Reach_Lamp : Duration_Access);
	
	task body Vehlice is
		Is_Accepted : Boolean := false;
	begin
		Put_Line("Auto " & License_Plate_Number.all & " rendszammal a lampa fele kozeledik " & Duration'Image(Time_To_Reach_Lamp.all) & " masodpercig.");
		delay Time_To_Reach_Lamp.all;
		Put_Line("Auto " & License_Plate_Number.all & " rendszammal a lampahoz ert!");
		while not Is_Accepted loop
			select 
				Lamp.Pass;
				Is_Accepted := true;
			or
				delay 0.2;
				Put_Line("Auto " & License_Plate_Number.all & " rendszammal a lampanal var.");
			end select;
		end loop;
	end Vehlice;
	
	type Vehlice_Access is access Vehlice;
	
	VA : Vehlice_Access;
	
begin
	for I in 1..10 loop
		delay 0.5; 
		VA := new Vehlice( new String'("ABC"), new Duration'(1.0) );
	end loop;
	Skip_Line;
	Controller.Stop;
end Main;