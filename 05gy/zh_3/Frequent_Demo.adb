with Ada.Text_IO;
with Most_Frequent;

procedure Frequent_Demo is
	function StringMostFrequent is new Most_Frequent(Character, Positive, String);
	
	DemoString : String(1..5) := "13345";
begin
	Ada.Text_IO.Put_Line(Character'Image(StringMostFrequent(DemoString)));
end Frequent_Demo;