function CompareReal
    // From https://github.com/modelica/Modelica-Compliance/blob/master/ModelicaCompliance/Util.mo
    "Compares two Reals, and checks if they are close enough to be considered equal."
    input Real a, b;
    input Real absTol = 1e-10 "Absolute tolerance.";
    input Real relTol = 1e-5 "Relative tolerance.";
    output Boolean equal;
protected
    Real diff;
algorithm
    diff := abs(a - b);
    equal := diff < absTol or diff <= max(abs(b), abs(a)) * relTol;
end CompareReal;
