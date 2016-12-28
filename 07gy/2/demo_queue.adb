with Ada.Text_IO;
with queue;

procedure demo_queue is
	package Sor is new queue(Integer);
	use Sor;
	
	Q : Queues(5);
begin
	for I in 1..5 loop
		Push_Front(Q, I);
	end loop;
	for I in 1..5 loop
		Ada.Text_IO.Put(Integer'Image(Get_Value(Q, I)));
	end loop;
end demo_queue;