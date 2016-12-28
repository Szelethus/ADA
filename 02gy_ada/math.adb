package body Math is

   function gcd ( A, B : Positive ) return Positive is
      X: Positive := A;
      Y: Positive := B;
   begin
      while X /= Y loop
         if X > Y then
            X := X - Y;
         else
            Y := Y - X;
         end if;
      end loop;
      return X;
   end gcd;

   function factorial( N: Natural ) return Positive is
      Fakt : Positive := 1;
   begin
      for I in 1..N loop
         Fakt := Fakt * I;
      end loop;
      return Fakt;
   end factorial;

   function sumAllPrev (A: natural) return Natural is
		Result: Natural := 0;
	begin
		for I in 1..A loop
			Result := Result + I;
		end loop;
		return Result;
	end sumAllPrev;
	
	function sign (A: Integer) return Integer is
	begin
		if A > 0 then
			return 1;
		elsif A = 0 then
			return 0;
		else
			return -1;
		end if;
	end sign;
	
	function nChooseK (N, K : Natural) return Natural is
		Result : Natural;
	begin
		Result := factorial(N)/(factorial(K)*factorial(N-K));
		return Result;
	end nChooseK;
	
--	function eulerNumber (P : Positive) return Real is
--		EulerNumber : Real := 1;
--	begin
--		for I in 1..P loop
--			EulerNumber := EulerNumber + 1/(factorial(I));
--		end loop;
--		return EulerNumber;
--	end eulerNumber;
	
	function add_digits (N : Natural) return Natural is
		Result : Natural := 0;
		Tmp : Natural := N;
	begin
		if Tmp < 10 then
			return Tmp;
		end if;
		loop
			Result := Result + Tmp mod 10;
			Tmp := tmp mod 10;
			exit when Tmp < 10;
		end loop;
		return Result + Tmp;
	end add_digits;
	
end Math;
