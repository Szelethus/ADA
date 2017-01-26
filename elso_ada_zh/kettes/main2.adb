with ADA.Text_IO, Linear_Search;
use ADA.Text_IO;

procedure Main2 is

	function Testing_Two_Marks return Boolean is

		type Int_Array is array(Positive range <>) of Integer;

		function Is_Odd(N : in Integer) return Boolean is (N mod 2 = 1);
		function Is_Even(N : in Integer) return Boolean is (N mod 2 = 0);
		function Three_Mod(N : in Integer) return Boolean is (N mod 3 = 0);

		procedure Search_Odd is new Linear_Search(Item=>Integer,Index=>Positive,Item_Array=>Int_Array,Condition=>Is_Odd);
		procedure Search_Even is new Linear_Search(Item=>Integer,Index=>Positive,Item_Array=>Int_Array,Condition=>Is_Even);
		procedure Search_Three_Mod is new Linear_Search(Item=>Integer,Index=>Positive,Item_Array=>Int_Array,Condition=>Three_Mod);

		Int_Array_Odd_Even_Cond_True : Int_Array := (3,5,7,2,1);
		Int_Array_Odd_Cond_True : Int_Array := (3,5,7,3,1);
		Int_Array_Even_Cond_True : Int_Array := (2,4,6,2,10);
		Int_Array_False : Int_Array := (8,4,5,7);

		function Correct(
			Search: access procedure (A: in Int_Array; Found: out Boolean; Pos: out Positive);
			Input: Int_Array;
			Should_Find: Boolean;
			Position_Should_Be: Positive
		) return Boolean 
		is
			Found: Boolean;
			Position: Positive; 
		begin
			Search(Input,Found,Position);
			if not Found then
				return not Should_Find;
			else
				return Should_Find and then Position_Should_Be = Position;
			end if;
		exception
			when others => return False;
		end;

	begin
		return
			Correct(Search_Odd'Access,Int_Array_Odd_Even_Cond_True, True, 1) and then
			Correct(Search_Even'Access,Int_Array_Odd_Even_Cond_True, True, 4) and then
			Correct(Search_Even'Access,Int_Array_Even_Cond_True, True, 1) and then
			Correct(Search_Three_Mod'Access,Int_Array_False, False, 1) and then
			Correct(Search_Odd'Access,Int_Array_Even_Cond_True, False, 1) and then
			Correct(Search_Odd'Access,Int_Array_Even_Cond_True, False, 1);
	end Testing_Two_Marks;

begin
	if not Testing_Two_Marks then
		Put_Line("Megbukott a teszteken :-( ");
	else
		Put_Line("Atment a teszteken :-) ");
	end if;
end Main2;