/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_CenterOfMass
    Real [2] out1, out2;
algorithm
    out1 := CenterOfMass({{0,0}, {1,0}, {1,1}, {0,1}});
    AssertRealEquality(out1[1], 0.5);
    AssertRealEquality(out1[2], 0.5);

    out2 := CenterOfMass({{0, 0}, {30, 0}, {0, 30}});
    AssertRealEquality(out2[1], 10);
    AssertRealEquality(out2[2], 10);
end test_CenterOfMass;
