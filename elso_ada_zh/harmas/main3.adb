with ADA.Text_IO, Linear_Search, Maps;
use ADA.Text_IO;

procedure Main3 is

	function Testing_Three_Marks return Boolean is
		-- Linear_Search Declaration
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

		--Maps Declaration

		package Integer_Maps is new Maps(Integer,Integer);
		Int_Maps_1 : Integer_Maps.Map(1);
		Int_Maps_5 : Integer_Maps.Map(5);

		function Map_Test return Boolean is
			get_Boolean : Boolean;
			get_Value : Integer;
			exc_count : Integer := 0;
		begin
			for I in Integer range 1..6 loop
				begin	
					Integer_Maps.Insert(Int_Maps_5,I,I+2);
					Integer_Maps.Get(Int_Maps_5,I,get_Value,get_Boolean);
					if not get_Boolean or get_Value /= I+2 then
						return False;
					end if;
				exception
					when Integer_Maps.Map_Error => exc_count := exc_count + 1;
				end;
			end loop;
			Integer_Maps.Insert(Int_Maps_1,10,10);
			begin
				Integer_Maps.Insert(Int_Maps_1,2,2);
				return False;
			exception
				when Integer_Maps.Map_Error => exc_count := exc_count + 1;
			end;
			if exc_count /= 2 then
				return False;
			end if;
			return True;
		end Map_Test;

	begin
		return
			Correct(Search_Odd'Access,Int_Array_Odd_Even_Cond_True, True, 1) and then
			Correct(Search_Even'Access,Int_Array_Odd_Even_Cond_True, True, 4) and then
			Correct(Search_Even'Access,Int_Array_Even_Cond_True, True, 1) and then
			Correct(Search_Three_Mod'Access,Int_Array_False, False, 1) and then
			Correct(Search_Odd'Access,Int_Array_Even_Cond_True, False, 1) and then
			Correct(Search_Odd'Access,Int_Array_Even_Cond_True, False, 1) and then
			Map_Test;
	end Testing_Three_Marks;

begin
	if not Testing_Three_Marks then
		Put_Line("Megbukott a teszteken :-( ");
	else
		Put_Line("Atment a teszteken :-) ");
	end if;
end Main3;