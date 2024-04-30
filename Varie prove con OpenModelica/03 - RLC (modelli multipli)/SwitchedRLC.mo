model SwitchedRLC

      // Componenti del circuito

      // "fixed" garantisce che il valore passato tramite
      // "start" non sia semplicemente un valore di fallback
      // ma che sia utilizzato come equazione iniziale

      StepVoltage Vs(V0=0, Vf=24, stepTime=0.5);
      
      Inductor inductor(L=1, i(fixed=true, start=0));
      Capacitor capacitor(C=1e-3, v(fixed=true, start=0));
      Resistor resistor(R=100);
      
      Ground ground;

equation

      connect(inductor.n, resistor.n);
      connect(capacitor.n, inductor.n);
      connect(inductor.p, Vs.p);
      connect(capacitor.p, ground.ground);
      connect(resistor.p, ground.ground);
      connect(Vs.n, ground.ground);

end SwitchedRLC;
