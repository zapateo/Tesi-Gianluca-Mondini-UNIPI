/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_CenterOfMass

    PointsArray in1;
    Real [2] out1;

    PointsArray in2;
    Real [2] out2;

    PointsArray in3;
    Real [2] out3;

    PointsArray in4;
    Real [2] out4;

algorithm

    in1.len := 0;
    in1 := PointsArrayAppend(in1, {0, 0});
    in1 := PointsArrayAppend(in1, {1, 0});
    in1 := PointsArrayAppend(in1, {1, 1});
    in1 := PointsArrayAppend(in1, {0, 1});
    out1 := CenterOfMass(in1);
    AssertRealEquality(out1[1], 0.5);
    AssertRealEquality(out1[2], 0.5);

    in2.len := 0;
    in2 := PointsArrayAppend(in2, {0, 0});
    in2 := PointsArrayAppend(in2, {30, 0});
    in2 := PointsArrayAppend(in2, {0, 30});
    out2 := CenterOfMass(in2);
    AssertRealEquality(out2[1], 10);
    AssertRealEquality(out2[2], 10);

    in3.len := 0;
    in3 := PointsArrayAppend(in3, {0, 0});
    in3 := PointsArrayAppend(in3, {300, 0});
    in3 := PointsArrayAppend(in3, {0, 300});
    out3 := CenterOfMass(in3);
    AssertRealEquality(out3[1], 100);
    AssertRealEquality(out3[2], 100);

    in4.len := 0;
    in4 := PointsArrayAppend(in4, {48, 0});
    in4 := PointsArrayAppend(in4, {0, 48});
    in4 := PointsArrayAppend(in4, {0, 100});
    in4 := PointsArrayAppend(in4, {1, 100});
    in4 := PointsArrayAppend(in4, {100, 1});
    in4 := PointsArrayAppend(in4, {100, 0});
    out4 := CenterOfMass(in4);
    AssertRealEquality(out4[1], 38.8181);
    AssertRealEquality(out4[2], 38.8181);

end test_CenterOfMass;
