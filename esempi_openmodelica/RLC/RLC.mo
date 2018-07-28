// Fonte: http://book.xogeny.com/behavior/equations/electrical/

model RLC "An R-L-C circuit model"

      // Definizione di alcuni tipi

      type Voltage = Real(unit="V");
      type Current = Real(unit="A");
      type Resistance = Real(unit="Ohm");
      type Capacitance = Real(unit = "F");
      type Inductance = Real(unit="H");

      // Definizione dei parametri

      parameter Voltage Vb = 24 "Battery Voltage";
      parameter Inductance L = 1;
      parameter Resistance R = 100;
      parameter Capacitance C = 1e-3;

      // Definizione delle variabili

      Voltage V;
      Current i_L;
      Current i_R;
      Current i_C;

equation

      // Le 4 equazioni necessarie al modello

      V = i_R * R;
      C * der(V) = i_C;
      L * der(i_L) = (Vb - V);
      i_L = i_R + i_C;

end RLC;
