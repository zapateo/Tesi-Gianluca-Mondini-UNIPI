model voronoi
  Modelica.Blocks.Interfaces.RealInput x1 annotation(
    Placement(visible = true, transformation(origin = {-94, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-94, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput y3 annotation(
    Placement(visible = true, transformation(origin = {-94, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-94, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput y2 annotation(
    Placement(visible = true, transformation(origin = {-94, -10}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-94, -10}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput y1 annotation(
    Placement(visible = true, transformation(origin = {-92, 56}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-92, 56}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput x2 annotation(
    Placement(visible = true, transformation(origin = {-96, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-96, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput x3 annotation(
    Placement(visible = true, transformation(origin = {-96, -46}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-96, -46}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput x_d1 annotation(
    Placement(visible = true, transformation(origin = {98, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_d1 annotation(
    Placement(visible = true, transformation(origin = {98, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Real out1[2];
  Real in1[2];
  Real in2[2];
  Real in3[2];
algorithm
  in1[1] := x1;
  in1[2] := y1;
  in2[1] := x2;
  in2[2] := y2;
  in3[1] := x3;
  in3[2] := y3;
  out1 := TargetPos({{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}}, {in1[1], in1[2]}, {{in2[1], in2[2]}, {in3[1], in3[2]}});

  x_d1 := out1[1];
  y_d1 := out1[2];
  annotation(
    uses(Modelica(version = "3.2.2")));
end voronoi;