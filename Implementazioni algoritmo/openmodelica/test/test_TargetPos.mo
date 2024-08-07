/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

model test_TargetPos

    Real [2] out1;

    Real [4,4] test2_edges;
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

    test2_edges := {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}};
    out2 := TargetPos(
        test2_edges,
        {30, 30},
        {{10, 10}, {20, 20}}
    );
    AssertRealEquality(out2[1], 54.7619);
    AssertRealEquality(out2[2], 54.7619);

    out3 := TargetPos(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        test3_primary_drone,
        {{20, 20}, {50, 50}}
    );
    AssertRealEquality(out3[1], 10);
    AssertRealEquality(out3[2], 10);

end test_TargetPos;
