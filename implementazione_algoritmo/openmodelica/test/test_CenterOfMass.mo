/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_CenterOfMass

    Real [2] out1;

    Real [2] out2;

    Real [3,2] in3;
    Real [2] out3;

algorithm

    out1 := CenterOfMass({{0,0}, {1,0}, {1,1}, {0,1}});
    AssertRealEquality(out1[1], 0.5);
    AssertRealEquality(out1[2], 0.5);

    out2 := CenterOfMass({{0, 0}, {30, 0}, {0, 30}});
    AssertRealEquality(out2[1], 10);
    AssertRealEquality(out2[2], 10);

    in3[1,1] := 0;
    in3[1,2] := 0;
    in3[2,1] := 300;
    in3[2,2] := 0;
    in3[3,1] := 0;
    in3[3,2] := 300;
    out3 := CenterOfMass(in3);
    AssertRealEquality(out3[1], 100);
    AssertRealEquality(out3[2], 100);

end test_CenterOfMass;
