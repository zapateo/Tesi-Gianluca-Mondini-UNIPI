// within RLC;

model Resistor "Modello di un resistore"
      parameter Types.Resistance R "Resistenza del resistore";
      extends TwoPin;
equation
      v = i * R "Legge di Ohm";
end Resistor;
