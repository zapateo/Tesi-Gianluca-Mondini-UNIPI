/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_CenterOfMass
    Real [2] out1;
algorithm
    out1 := CenterOfMass({{0,0}, {1,0}, {1,1}, {0,1}});
    AssertRealEquality(out1[1], 0.5);
    AssertRealEquality(out1[2], 0.5);
end test_CenterOfMass;
