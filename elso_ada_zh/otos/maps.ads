generic 
	type Key is private;
	type Value is private;
	
package Maps is

	Map_Error : exception;
	
	type Map (Capacity : Natural) is private;
	type Pair is private;
	
	type PairArray is array (Natural range <>) of Pair;
	
	procedure Insert (M : in out Map; NewKey : Key; NewValue : Value);
	procedure Get (M : in out Map; NewKey : Key; NewValue : out Value; B : out Boolean);
	
	function Size (M : in Map) return Natural;
	
	generic
		with procedure Action(NewKey : in out Key; NewValue : in out Value);
	procedure For_Each (M : in out Map);
private

	type Pair is record
		K : Key;
		V : Value;
	end record;
	
	type Map (Capacity : Natural) is record
		CurrentSize : Natural := 0;
		Pairs : PairArray (1..Capacity);
	end record;
	
end Maps;