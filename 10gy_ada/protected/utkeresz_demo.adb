with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Calendar;
use Ada.Calendar;

procedure utkereszt_demo is

	type Traffic_Light_Colors is (Red, Yellow, Orange, Green);
	
	protected Traffic_Light is
		procedure Change;
		function Color return Traffic_Light_Colors;
		
		entry Pass;
	private
		Current_Color : Traffic_Light_Colors := Red;
	end Traffic_Light;
	
	protected body Traffic_Light is
	
		procedure Change is
		begin
			if Current_Color = Green then
				Current_Color := Red;
			else
				Current_Color := Traffic_Light_Colors'Succ(Current_Color);
			end if;
		Put_Line("A lampa aktualis szine " & Traffic_Light_Colors'Image(Current_Color));
		end Change;
		
		function Color return Traffic_Light_Colors is
		begin
			return Current_Color;
		end Color;
		
		entry Pass when Current_Color = Green is
		begin
			Put_Line("Athaladt egy auto");
		end Pass;

	end Traffic_Light;

	task Traffic_Manager;
	
	task body Traffic_Manager is
	begin
		for I in 1..3 loop
			Traffic_Light.Change;
			delay 3.0;
			Traffic_Light.Change;
			delay 0.5;
			Traffic_Light.Change;
			delay 2.0;
			Traffic_Light.Change;
			delay 1.0;
		end loop;
	end Traffic_Manager;
	
	type String_Access is access String;
	type Duration_Access is access Duration;
	
	task type Vehlice (License_Plate_Number : String_Access; Time_To_Reach_Traffic_Light : Duration_Access);
	
	task body Vehlice is
		Is_Accepted : Boolean := false;
	begin
		Put_Line("Auto " & License_Plate_Number.all & " rendszammal a lampa fele kozeledik " & Time_To_Reach_Traffic_Light.all & " masodpercig.");
		delay Time_To_Reach_Traffic_Light.all;
		Put_Line("Auto " & License_Plate_Number.all & " rendszammal a lampahoz ert!");
		while not Is_Accepted loop
			select 
				Traffic_Light.Pass;
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
	delay 0.2; VA := new Vehlice_Access( new String'("ABC"), new Duration(1.0) );
	delay 0.2; VA := new Vehlice_Access( new String'("DFG"), new Duration(0.5) );
	delay 0.2; VA := new Vehlice_Access( new String'("IJK"), new Duration(0.8) );
end utkereszt_demo;