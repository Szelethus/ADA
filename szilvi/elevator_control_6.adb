with Ada.Text_IO, Ada.Calendar;
use Ada.Text_IO;
use Ada.Calendar;

procedure Elevator_Control_6 is

--Types:

   --Motor
   type Command_Type is (Forward, Backward, Power_Off);
   type Speed_Type is new Integer range -1..1;

   --Elevator
   subtype Position_Type is Integer range 0..40;

   --Controller
   type Floor_Type is new Integer range 0..4;

--Tasks:

   task Motor is
      entry Command(move : Command_Type);
   end Motor;

   task Elevator is
      entry Move_Up;
      entry Move_Down;
   end Elevator;

   task Controller is
      entry Sensor(Floor : Floor_Type);
   end Controller;

--Tasks' bodyes:

   task body Motor is

      Speed : Speed_Type := 0; --contains the speed of the motor
      Distance : Duration :=0.0; --contains the distance which the motor has moved
      Start_Forward_Time : Time := Clock; --the time, when the motor starts moving forward
      Start_Backward_Time : Time := Clock; --the time, when the motor starts mowing backward
      Wait_Time : Duration := 0.1; -- the time, after the motor starts moving the elevator if don't get command
      Is_Working : Boolean := True; --true while the motor isn't powered off
      Motor_Burned_Out : exception;

      --Auxiliary functions and procedures:

      procedure Print_Motor(Command : Command_Type) is --prints the motor's situation
      begin
         Put_Line("Command: " & Command_Type'Image(Command) & "; Distance: " & Duration'Image(Distance) & "; Speed: " & Speed_Type'Image(Speed));
      end Print_Motor;

      procedure Move_Elevator is --moves the elevator
      begin
         if Speed = 1 then
            select
               Elevator.Move_Up;
            or
               delay Wait_Time;
               raise Motor_Burned_Out;
            end select;
         elsif Speed = -1 then
            select
               Elevator.Move_Down;
            or
               delay Wait_Time;
               raise Motor_Burned_Out;
            end select;
         else
            Put_Line("Illes egy geci");
         end if;
      end Move_Elevator;

      procedure Move_Forward is --moves forward the motor
      begin
         Distance := Distance + Clock - Start_Forward_Time;
         Start_Forward_Time := Clock;
         --Move_Elevator;
      end Move_Forward;

      procedure Move_Backward is --moves backward the motor
      begin
         Distance := Distance - (Clock - Start_Backward_Time);
         Start_Backward_Time := Clock;
         --Move_Elevator;
      end Move_Backward;

      procedure Stop_Forward is --stops the motor after moving forward
      begin
         Distance := Distance + Clock - Start_Forward_Time;
         --Move_Elevator;
      end Stop_Forward;

      procedure Stop_Backward is --stops the motor after moving backward
      begin
         Distance := Distance - (Clock - Start_Backward_Time);
         --Move_Elevator;
      end Stop_Backward;

   begin

      while Is_Working loop --while isn't powered off
         select
            accept Command(Move : Command_Type) do

               if Move = Forward then
                  if Speed = 0 then
                     Speed := 1;
                     Start_Forward_Time := Clock;
                     Move_Forward;
                     --Print_Motor(Move);
                  elsif Speed = 1 then
                     Move_Forward;
                     Start_Forward_Time := Clock;
                     --Print_Motor(Move);
                  elsif Speed = -1 then
                     Speed := 0;
                     Stop_Backward;
                     --Print_Motor(Move);
                  end if;

               elsif Move = Backward then
                  if Speed = 0 then
                     Speed := -1;
                     Start_Backward_Time := Clock;
                     Move_Backward;
                     --Print_Motor(Move);
                  elsif Speed = 1 then
                     Speed := 0;
                     Stop_Forward;
                     --Print_Motor(Move);
                  elsif Speed = -1 then
                     Move_Backward;
                     --Print_Motor(Move);
                  end if;

               elsif Move = Power_Off then
                  Is_Working := false;
               end if;

            end Command;

            or
               delay Wait_Time;
               Move_Elevator;
         end select;
      end loop;

   exception
      when Motor_Burned_Out => Put_Line("The motor is burned out.");

   end Motor;



   task body Elevator is

      Position : Position_Type := 0;
      Interval : Integer := 1; --approximate value to the floors

      --Auxiliary functions and procedures:

      procedure Print_Elevator(Move : String) is
      begin
         Put_Line("The elevator is " & Move & ". Position : " & Position_Type'Image(Position));
      end Print_Elevator;

      procedure Check_Floor is
      begin
         if 0 - Interval <= Position and Position <= 0 + Interval then
            Controller.Sensor(0);
            Put_Line("Floor: 0");
         elsif 10 - Interval <= Position and Position <= 10 + Interval then
            Controller.Sensor(1);
            Put_Line("Floor: 1");
         elsif 20 - Interval <= Position and Position <= 20 + Interval then
            Controller.Sensor(2);
            Put_Line("Floor: 2");
         elsif 30 - Interval <= Position and Position <= 30 + Interval then
            Controller.Sensor(3);
            Put_Line("Floor: 3");
         elsif 40 - Interval <= Position and Position <= 40 + Interval then
            Controller.Sensor(4);
            Put_Line("Floor: 4");
         end if;
      end Check_Floor;

   begin
      loop
         select
            when Position < 40 => accept Move_Up  do
                  Position := Position + 1;
                  Print_Elevator("moving up");
                  Check_Floor;
               end Move_Up;
         or
            when Position > 0 => accept Move_Down  do
                  Position := Position - 1;
                  Print_Elevator("moving down");
                  Check_Floor;
               end Move_Down;
         or
            terminate;
         end select;
      end loop;
   end Elevator;



   task body Controller is --entry Sensor(Floor : Floor_Type);
       Is_Not_On_Top: Boolean := True;
   begin
      Motor.Command(Forward);
      while Is_Not_On_Top loop
      select
         accept Sensor(Floor : Floor_Type) do
               if Floor = 4 then
                  Is_Not_On_Top := False;
                  Put_Line("Elevator is on top.");
               end if;
         end Sensor;
      or
           terminate;
         end select;
      end loop;
      Motor.Command(Power_Off);
   end Controller;

begin
   delay 5.0;
   Motor.Command(Power_Off);

end Elevator_Control_6;
