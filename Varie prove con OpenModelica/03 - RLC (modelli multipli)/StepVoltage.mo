// within RLC;

model StepVoltage "Un generatore di tensione a gradino"
      parameter Types.Voltage V0 "Tensione iniziale del generatore";
      parameter Types.Voltage Vf "Tensione finale del generatore";
      parameter Types.Time stepTime "Istante di tempo in cui la tensione passa da V0 a Vf";
      extends TwoPin;
equation
      v = if time >= stepTime then Vf else V0;
end StepVoltage;
