with Ada.Text_IO; use Ada.Text_IO;

procedure Kocsma is

    type Ital is (Sor, Bor, Palinka);

    task Kocsmaros is
        entry Tolt( Mit: in Ital );
    end Kocsmaros;

    task body Kocsmaros is
    begin
        for I in 1..20 loop
            accept Tolt ( Mit: in Ital ) do
                Put_Line(Integer'Image(I) & " Toltok " & Ital'Image(Mit) & 't');
                case Mit is
                    when Sor => delay 1.0;
                    when Bor => delay 0.2;
                    when Palinka => delay 0.3;
                end case;
            end Tolt;
        end loop;
    end Kocsmaros;

    task type Reszeg;

    task body Reszeg is
        Sorivas_Ideje: Duration := 1.0;
    begin
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
    end Reszeg;

    type Reszeg_Access is access Reszeg;
    R: Reszeg_Access;

begin

    for I in 1..5 loop
        delay 3.0;
        Put_Line("Egy reszeg tevedt erre.");
        R := new Reszeg;
    end loop;

end Kocsma;

