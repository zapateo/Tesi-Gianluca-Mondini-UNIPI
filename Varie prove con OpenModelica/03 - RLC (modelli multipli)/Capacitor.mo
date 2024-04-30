// within RLC;
model Capacitor "Modello di un condensatore"
    parameter Types.Capacitance C "Capacità del condensatore";
  extends TwoPin;
  PositivePin positivePin1 annotation(
    Placement(visible = true, transformation(origin = {78, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-76, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  NegativePin negativePin1 annotation(
    Placement(visible = true, transformation(origin = {-44, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {82, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  C * der(v) = i;
  annotation(
    Icon(graphics = {Line(origin = {-35.31, 2.37}, points = {{-22, 3.5}, {22, 3.5}, {22, 57.5}, {22, -56.5}}, thickness = 2), Line(origin = {25.92, 2.59}, rotation = 180, points = {{-22, 3.5}, {22, 3.5}, {22, 57.5}, {22, -56.5}}, thickness = 2)}));
end Capacitor;