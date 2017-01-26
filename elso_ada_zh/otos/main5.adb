with ADA.Text_IO, Linear_Search, Maps, Integer_Integer_Maps;
use ADA.Text_IO;

procedure Main5 is

	function Testing_Five_Marks return Boolean is
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

		procedure Key_Value_Add(K : in out Integer; V : in out Integer) is
		begin
			K := K + 2;
			V := V + 3;
		end Key_Value_Add;
		procedure Square_Value(K : in out Integer; V : in out Integer) is
		begin
			V := V * V;
		end Square_Value;

		Int_Maps_1 : Integer_Integer_Maps.Map(1);
		Int_Maps_5 : Integer_Integer_Maps.Map(5);
		Int_Maps_7 : Integer_Integer_Maps.Map(7);

		procedure Integer_Map_Add is new Integer_Integer_Maps.For_Each(Key_Value_Add);
		procedure Integer_Map_Square_Value is new Integer_Integer_Maps.For_Each(Square_Value);

		function Map_Test return Boolean is
			get_Boolean : Boolean;
			get_Value : Integer;
			exc_count : Integer := 0;
		begin
			for I in Integer range 1..6 loop
				begin
					Integer_Integer_Maps.Insert(Int_Maps_5,I,I*2);
					Integer_Integer_Maps.Get(Int_Maps_5,I,get_Value,get_Boolean);
					if not get_Boolean or get_Value /= I*2 then
						return False;
					end if;
				exception
					when Integer_Integer_Maps.Map_Error => exc_count := exc_count + 1;
				end;
			end loop;
			Integer_Integer_Maps.Insert(Int_Maps_1,10,10);
			begin
				Integer_Integer_Maps.Insert(Int_Maps_1,2,2);
				return False;
			exception
				when Integer_Integer_Maps.Map_Error => exc_count := exc_count + 1;
			end;
			if exc_count /= 2 then
				return False;
			end if;
			for I in Integer range 1..4 loop
				Integer_Integer_Maps.Insert(Int_Maps_7,I,I*2);
			end loop;
			if Integer_Integer_Maps.Size(Int_Maps_7) /= 4 then
				return False;
			end if;
			for I in Integer range 2..6 loop
				begin
					Integer_Integer_Maps.Insert(Int_Maps_7,I,I*2);
				exception
					when Integer_Integer_Maps.Map_Error => exc_count := exc_count + 1;
				end;
			end loop;
			if Integer_Integer_Maps.Size(Int_Maps_7) /= 6 then
				return False;
			end if;
			if exc_count /= 2 then
				return False;
			end if;
			Integer_Map_Add(Int_Maps_7);
			for I in Integer range 1..6 loop
				Integer_Integer_Maps.Get(Int_Maps_7,I+2,get_Value,get_Boolean);
				if not get_Boolean or get_Value /= (I*2)+3 then
					return False;
				end if;
			end loop;
			Integer_Map_Square_Value(Int_Maps_5);
			for I in Integer range 1..5 loop
				Integer_Integer_Maps.get(Int_Maps_5,I,get_Value,get_Boolean);
				if not get_Boolean or get_Value /= ((I*2) * (I*2)) then
					return False;
				end if;
			end loop;
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
	end Testing_Five_Marks;

begin
	if not Testing_Five_Marks then
		Put_Line("Megbukott a teszteken :-( ");
	else
		Put_Line("Atment a teszteken :-) ");
	end if;
end Main5;