model voronoi
  Real out1[2];
  Real in1[2];
  Real in2[2];
  Real in3[2];
algorithm
  in1[1] := 10;
  in1[2] := 10;
  in2[1] := 20;
  in2[2] := 20;
  in3[1] := 50;
  in3[2] := 50;
  out1 := TargetPos({{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}}, {in1[1], in1[2]}, {{in2[1], in2[2]}, {in3[1], in3[2]}});

  x_d1 := out1[1];
  y_d1 := out1[2];
end voronoi;
