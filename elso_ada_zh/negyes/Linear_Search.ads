generic
	type Item is private;
	type Index is (<>);
	type Item_Array is array (Index range <>) of Item;
	with function Condition (I : Item) return Boolean;
procedure Linear_Search (T : in Item_Array; B : out Boolean; Ind : out Index);