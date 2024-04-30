// within RLC;

model Ground "Massa elettrica"
      PositivePin ground "Pin di massa";
equation
      ground.v = 0;
end Ground;
