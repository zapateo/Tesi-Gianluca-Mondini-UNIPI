/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_TargetPos
    Real [2] target1, target2, target3;
algorithm
    //--------------------------------------------------------------------
    target1 := TargetPos(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        {10, 10},
        {{20, 20}, {30, 30}}
    );
    AssertRealEquality(target1[1], 10);
    AssertRealEquality(target1[2], 10);
    //--------------------------------------------------------------------
    target2 := TargetPos(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        {30, 30},
        {{10, 10}, {20, 20}}
    );
    AssertRealEquality(target2[1], 63.3333);
    AssertRealEquality(target2[2], 63.3333);
    //--------------------------------------------------------------------
    target3 := TargetPos(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        {10, 10},
        {{20, 20}, {50, 50}}
    );
    AssertRealEquality(target3[1], 10);
    AssertRealEquality(target3[2], 10);
    //--------------------------------------------------------------------
end test_TargetPos;
