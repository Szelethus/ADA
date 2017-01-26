generic 
	type Key is private;
	type Value is private;
	
package Maps is
	Map_Error : exception;
	type Map (Capacity : Natural) is private;
	
	type Pair is record
		K : Key;
		V : Value;
	end record;
	
	type PairArray is array (Natural range <>) of Pair;
	
	procedure Insert (M : in out Map; NewKey : Key; NewValue : Value);
	procedure Get (M : in out Map; NewKey : Key; NewValue : out Value; B : out Boolean);
private
	type Map (Capacity : Natural) is record
		CurrentSize : Natural := 0;
		Pairs : PairArray (1..Capacity);
	end record;
end Maps;