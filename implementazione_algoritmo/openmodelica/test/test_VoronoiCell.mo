/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_VoronoiCell

    Real [2] test1_primary_drone = {10, 10};
    EdgesArray out1;

    EdgesArray out2;

    EdgesArray out3;

    EdgesArray out4;

algorithm
    out1 := VoronoiCell(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        test1_primary_drone,
        {{20, 20}, {30, 30}}
    );
    assert(out1.len == 3, "out1.len != 3");
    AssertVectorEquality(out1.elements[1], {30, 0, 0, 0});
    AssertVectorEquality(out1.elements[2], {0, 30, 0, 0});
    AssertVectorEquality(out1.elements[3], {30, 0, 0, 30});
    //--------------------------------------------------------------------------
    out2 := VoronoiCell(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        {25, 25},
        {{75, 75}}
    );
    assert(out2.len == 3, "out2.len != 3");
    AssertVectorEquality(out2.elements[1], {100, 0, 0, 0});
    AssertVectorEquality(out2.elements[2], {0, 100, 0, 0});
    AssertVectorEquality(out2.elements[3], {100, 0, 0, 100});
    //--------------------------------------------------------------------------
    out3 := VoronoiCell(
        {{100, 0, 300, 0}, {300, 0, 300, 200}, {300, 200, 200, 400}, {200, 400, 0, 200}, {0, 200, 100, 0}},
        {200, 300},
        {{100, 100}, {100, 200}}
    );
    assert(out3.len == 5, "out3.len != 5");
    AssertVectorEquality(out3.elements[1], {300,200,200,400});
    AssertVectorEquality(out3.elements[2], {300,125,300,200});
    AssertVectorEquality(out3.elements[3], {100,300,200,400});
    AssertVectorEquality(out3.elements[4], {250,150,300,125});
    AssertVectorEquality(out3.elements[5], {100,300,250,150});
    //--------------------------------------------------------------------------
    out4 := VoronoiCell(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        {30, 30},
        {{10, 10}, {20, 20}}
    );
    assert(out4.len == 5, "out4.len != 5");
    AssertVectorEquality(out4.elements[1], {100, 0, 100, 100});
    AssertVectorEquality(out4.elements[2], {100, 100, 0, 100});
    AssertVectorEquality(out4.elements[3], {50, 0, 100, 0});
    AssertVectorEquality(out4.elements[4], {0, 50, 0, 100});
    AssertVectorEquality(out4.elements[5], {50, 0, 0, 50});
end test_VoronoiCell;
