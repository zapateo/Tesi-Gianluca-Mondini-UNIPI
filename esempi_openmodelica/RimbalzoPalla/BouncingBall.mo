// Fonte: http://book.xogeny.com/behavior/discrete/bouncing/

model BouncingBall "Modello di una palla rimbalzante"

      type Height = Real(unit="m");
      type Velocity = Real(unit = "m/s");

      // COR (Coefficient Of Restitution)
      //
      // COR = 0 -> Collisione perfettamente anaelastica
      // COR = 1 -> Collisione perfettamente elastica
      parameter Real e = 0.8 "Coefficiente di restituzione";

      parameter Height h0 = 1.0 "Altezza iniziale";

      Height h "Altezza";
      Velocity v(start=0.0, fixed=true) "Velocità";

initial equation

      h = h0;

equation

      v = der(h);
      der(v) = -9.81;
      when h < 0 then
            reinit(v, -e * pre(v));
      end when;

end BouncingBall;
