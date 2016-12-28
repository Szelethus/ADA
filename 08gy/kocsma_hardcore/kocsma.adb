with Seged, Ada.Calendar; use Seged, Ada.Calendar;

procedure Kocsma is

    Ajto: Szemafor(5);
          -- Belepes: P
          -- Kilepes: V

    type Ital is (Sor, Bor, Palinka);

    task Kocsmaros is
        entry Tolt( Mit: in Ital );
        entry Borravalo;
    end Kocsmaros;

    task body Kocsmaros is
        Munkaido_Vege: Time := Clock + 10.0;
        -- Lejart_A_Munkaido: Boolean := False;
        Borravalok_Szama: Natural := 0;
    begin
        -- while not Lejart_A_Munkaido loop
        while Clock < Munkaido_Vege loop       -- rovidebb tulora
            select
               accept Tolt ( Mit: in Ital ) do
                  Put_Line("Toltok " & Ital'Image(Mit) & 't');
                  case Mit is
                       when Sor => delay 1.0;
                       when Bor => delay 0.2;
                       when Palinka => delay 0.3;
                  end case;
               end Tolt;
               select
                  accept Borravalo; Borravalok_Szama := Borravalok_Szama + 1;
               or delay 0.2;
               end select;
            or delay until Munkaido_Vege;
               -- Lejart_A_Munkaido := True;
            end select;
        end loop;
        Put_Line( "Na, en hazamegyek. osszeszedtem " &
                  Natural'Image(Borravalok_Szama) & " borravalot.");
    end Kocsmaros;

    task type Reszeg;
    task body Reszeg is
        Sorivas_Ideje: Duration := 1.0;
    begin
        loop
           select
              Ajto.P;  -- Belep
              Kocsmaros.Tolt(Palinka);
              Put_Line("Benyomok egy felest.");
              delay 0.1;
              Kocsmaros.Tolt(Bor);
              Put_Line("Benyomok egy pohar bort.");
              delay 0.3;
              loop
                  Kocsmaros.Tolt(Sor);
                  Put_Line("Benyomok egy korso sort.");
                  delay Sorivas_Ideje;
                  Sorivas_Ideje := 2 * Sorivas_Ideje;
              end loop;
           else
              Put_Line("Elmegyek a parkba szunyalni.");
              delay 1.0;
           end select;
        end loop;
    exception
        when Tasking_Error => Put_Line("Keresek egy masik helyet.");
                              Ajto.V;  -- Kilep
    end Reszeg;
    type Reszeg_Access is access Reszeg;
    R: Reszeg_Access;

    type PString is access String;
    task type Egyetemista ( Nev: PString );
    task body Egyetemista is
    begin
        select
            Ajto.P;
            Kocsmaros.Tolt(Bor);
            select
                 Kocsmaros.Borravalo;
            or delay 0.05;
               Put_Line("Ha nem kell, hat nem kell.");
            end select;
            Put_Line(Nev.all & " borozik.");
            delay 1.5;
            Ajto.V;
         or delay 1.0;
            Put_Line("Inkabb elmegyek Ada eloadasra.");
         end select;
    exception
        when Tasking_Error => Put_Line("Keresek egy masik helyet.");
                              Ajto.V;  -- Kilep
    end Egyetemista;
    type Egyetemista_Access is access Egyetemista;
    E: Egyetemista_Access;
    Nevek: constant array (1..10) of PString := (
             new String'("Jani"), new String'("Peti"), new String'("Mari"), 
             new String'("Juci"), new String'("Bela"), new String'("Gabi"), 
             new String'("Zoli"), new String'("Dani"), new String'("Geza"),
             new String'("Rozi") );

begin

    for I in 1..10 loop
        delay 0.5;
        if Veletlen < 0.5 then
           Put_Line("Egy reszeg tevedt erre.");
           R := new Reszeg;
        else
           Put_Line("Egy egyetemista tevedt erre.");
           E := new Egyetemista(Nevek(Integer(Veletlen*10.0+0.5)));
        end if;
    end loop;

end Kocsma;

