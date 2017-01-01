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
	
	protected Crossroad is
		entry Cross(Cross_Time : Duration_Access; License_Plate_Number : String_Access);
		procedure Wake_Up;
		function Get_Cross_Count return Natural;
	end Crossroad;
	
	task type Signal;
	type Signal_Access is access Signal;
	
	task body Signal is
	begin
		Crossroad.Wake_Up;
	end Signal;
	
	protected body Lamp is
	
		procedure Switch is
			SA : Signal_Access;
		begin
			if Current_Color = Yellow then
				Current_Color := Red;
			else
				Current_Color := Lamp_Color'Succ(Current_Color);
				if Current_Color = Green then
					SA := new Signal;
				end if;
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
					Put_Line("Kontroller kikapcsolva.");
				end Stop;
			or
				delay Wait_Time(Lamp.Color);
				Lamp.Switch;
			end select;
		end loop;
	end Controller;
	
	task type Vehlice (License_Plate_Number : String_Access);
	
	task body Vehlice is
		Cross_Time : Duration := 1.0;
		Has_Crossed : Boolean := False;
	begin
		Put_Line("Auto " & License_Plate_Number.all & " rendszammal a lampahoz ert!");
		while not Has_Crossed loop
			select 
				Crossroad.Cross(new Duration'(Cross_Time), License_Plate_Number);
				Has_Crossed := True;
			else
				Cross_Time := 3.0;
			end select;
		end loop;
	end Vehlice;
	
	protected body Crossroad is
	
		procedure Wake_Up is
		begin
			null;
		end Wake_Up;
		
		entry Cross(Cross_Time : Duration_Access; License_Plate_Number : String_Access) when Lamp.Color = Green is
		begin
			delay Cross_Time.all;
			Put_Line("Auto " & License_Plate_Number.all & " rendszammal a athaladt!");
		end Cross;
		
		function Get_Cross_Count return Natural is
		begin
			return Cross'Count;
		end Get_Cross_Count;
		
	end Crossroad;
	
	type Vehlice_Access is access Vehlice;
	VA : Vehlice_Access;
	
begin
	for I in 1..10 loop
		delay 0.5; 
		VA := new Vehlice( new String'("ABC" & Integer'Image(I)));
	end loop;
	Skip_Line;
	Controller.Stop;
end Main;