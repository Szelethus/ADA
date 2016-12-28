with Ada.Text_IO;
with Has_Repetitions;

procedure Repetition_Demo is
	function Has_Double_Letters is new Has_Repetitions(Character, Positive, String);
	Check : String(1..9) := "nnyukpdlt";
begin
	if Has_Double_Letters(Check) then
		Ada.Text_IO.Put_Line("Van benne egyezes!");
	else
		Ada.Text_IO.Put_Line("Nincs benne egyezes!");
	end if;
end Repetition_Demo;