/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_VoronoiCell

    Real [2] test1_primary_drone = {10, 10};
    Real [3, 4] out1;

    Real [3, 4] out2;

    Real [5, 4] out3;

    Real [5, 4] out4;

algorithm
    out1 := VoronoiCell(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        test1_primary_drone,
        {{20, 20}, {30, 30}}
    );
    AssertVectorEquality(out1[1], {30, 0, 0, 0});
    AssertVectorEquality(out1[2], {0, 30, 0, 0});
    AssertVectorEquality(out1[3], {30, 0, 0, 30});
    //--------------------------------------------------------------------------
    out2 := VoronoiCell(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        {25, 25},
        {{75, 75}}
    );
    AssertVectorEquality(out2[1], {100, 0, 0, 0});
    AssertVectorEquality(out2[2], {0, 100, 0, 0});
    AssertVectorEquality(out2[3], {100, 0, 0, 100});
    //--------------------------------------------------------------------------
    out3 := VoronoiCell(
        {{100, 0, 300, 0}, {300, 0, 300, 200}, {300, 200, 200, 400}, {200, 400, 0, 200}, {0, 200, 100, 0}},
        {200, 300},
        {{100, 100}, {100, 200}}
    );
    AssertVectorEquality(out3[1], {300,200,200,400});
    AssertVectorEquality(out3[2], {300,125,300,200});
    AssertVectorEquality(out3[3], {100,300,200,400});
    AssertVectorEquality(out3[4], {250,150,300,125});
    AssertVectorEquality(out3[5], {100,300,250,150});
    //--------------------------------------------------------------------------
    out4 := VoronoiCell(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        {30, 30},
        {{10, 10}, {20, 20}}
    );
    AssertVectorEquality(out4[1], {100, 0, 100, 100});
    AssertVectorEquality(out4[2], {100, 100, 0, 100});
    AssertVectorEquality(out4[3], {50, 0, 100, 0});
    AssertVectorEquality(out4[4], {0, 50, 0, 100});
    AssertVectorEquality(out4[5], {50, 0, 0, 50});
end test_VoronoiCell;
