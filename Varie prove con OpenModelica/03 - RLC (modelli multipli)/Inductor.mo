// within RLC;

model Inductor "Modello di un induttore"
      parameter Types.Inductance L "Induttanza dell'induttore";
      extends TwoPin;
equation
      L * der(i) = v;
end Inductor;
