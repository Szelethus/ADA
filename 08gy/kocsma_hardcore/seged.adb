with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

package body Seged is

  task Kiiro is
    entry Kiir( S: in String );
  end Kiiro;

  task body Kiiro is
  begin
     loop
         select
            accept Kiir( S: in String ) do Ada.Text_IO.Put_Line(S); end;
         or terminate;
         end select;
     end loop;
  end Kiiro;
	
  procedure Put_Line( S: in String ) is begin Kiiro.Kiir(S); end;

  task Veletlen_Gyarto is
     entry Veletlen ( F: out Float );
  end Veletlen_Gyarto;

  task body Veletlen_Gyarto is
     G: Generator;
  begin
     Reset(G);
     loop
         select
            accept Veletlen( F: out Float ) do F := Random(G); end;
         or terminate;
         end select;
     end loop;
  end Veletlen_Gyarto;

  function Veletlen return Float is
     F: Float;
  begin
     Veletlen_Gyarto.Veletlen(F);
     return F;
  end Veletlen;

  task body Szemafor is
     Bent: Natural := 0;
  begin
     loop
        select
           when Bent < Max => accept P; Bent := Bent + 1;
        or accept V; Bent := Bent - 1;
        or terminate;
        end select;
     end loop;
  end Szemafor;

end Seged;

