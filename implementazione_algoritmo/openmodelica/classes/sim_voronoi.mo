model sim_voronoi
  voronoi voronoi1 annotation(
    Placement(visible = true, transformation(origin = {47, -3}, extent = {{-49, -49}, {49, 49}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 50)  annotation(
    Placement(visible = true, transformation(origin = {-74, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 20)  annotation(
    Placement(visible = true, transformation(origin = {-80, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 10)  annotation(
    Placement(visible = true, transformation(origin = {-76, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const2.y, voronoi1.x3) annotation(
    Line(points = {{-64, -70}, {-16, -70}, {-16, -64}, {40, -64}, {40, -52}, {40, -52}}, color = {0, 0, 127}));
  connect(const2.y, voronoi1.y3) annotation(
    Line(points = {{-64, -70}, {62, -70}, {62, -52}, {60, -52}}, color = {0, 0, 127}));
  connect(const.y, voronoi1.y2) annotation(
    Line(points = {{-69, -2}, {-60, -2}, {-60, -10}, {0, -10}, {0, -8}}, color = {0, 0, 127}));
  connect(const.y, voronoi1.x2) annotation(
    Line(points = {{-69, -2}, {-60, -2}, {-60, 8}, {0, 8}, {0, 6}}, color = {0, 0, 127}));
  connect(const1.y, voronoi1.x1) annotation(
    Line(points = {{-62, 70}, {42, 70}, {42, 44}, {42, 44}}, color = {0, 0, 127}));
  connect(const1.y, voronoi1.y1) annotation(
    Line(points = {{-62, 70}, {58, 70}, {58, 44}, {56, 44}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.2")));end sim_voronoi;