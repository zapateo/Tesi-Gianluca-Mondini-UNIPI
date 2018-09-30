/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_TargetPos

    Real [2] out1;

    Real [2] out2;

    Real [2] test3_primary_drone = {10, 10};
    Real [2] out3;

algorithm

    out1 := TargetPos(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        {10, 10},
        {{20, 20}, {30, 30}}
    );
    AssertRealEquality(out1[1], 10);
    AssertRealEquality(out1[2], 10);

    out2 := TargetPos(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        {30, 30},
        {{10, 10}, {20, 20}}
    );
    AssertRealEquality(out2[1], 63.3333);
    AssertRealEquality(out2[2], 63.3333);

    out3 := TargetPos(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        test3_primary_drone,
        {{20, 20}, {50, 50}}
    );
    AssertRealEquality(out3[1], 10);
    AssertRealEquality(out3[2], 10);

end test_TargetPos;
