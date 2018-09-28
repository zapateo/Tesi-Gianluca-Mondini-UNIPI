/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_VoronoiCell
    Real [3, 4] edges1;
    Real [3, 4] edges2;
    Real [5, 4] edges3;
    Real [5, 4] edges4;
algorithm
    edges1 := VoronoiCell(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        {10, 10},
        {{20, 20}, {30, 30}}
    );
    AssertVectorEquality(edges1[1], {30, 0, 0, 0});
    AssertVectorEquality(edges1[2], {0, 30, 0, 0});
    AssertVectorEquality(edges1[3], {30, 0, 0, 30});
    //--------------------------------------------------------------------------
    edges2 := VoronoiCell(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        {25, 25},
        {{75, 75}}
    );
    AssertVectorEquality(edges2[1], {100, 0, 0, 0});
    AssertVectorEquality(edges2[2], {0, 100, 0, 0});
    AssertVectorEquality(edges2[3], {100, 0, 0, 100});
    //--------------------------------------------------------------------------
    edges3 := VoronoiCell(
        {{100, 0, 300, 0}, {300, 0, 300, 200}, {300, 200, 200, 400}, {200, 400, 0, 200}, {0, 200, 100, 0}},
        {200, 300},
        {{100, 100}, {100, 200}}
    );
    AssertVectorEquality(edges3[1], {300,200,200,400});
    AssertVectorEquality(edges3[2], {300,125,300,200});
    AssertVectorEquality(edges3[3], {100,300,200,400});
    AssertVectorEquality(edges3[4], {250,150,300,125});
    AssertVectorEquality(edges3[5], {100,300,250,150});
    //--------------------------------------------------------------------------
    edges4 := VoronoiCell(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        {30, 30},
        {{10, 10}, {20, 20}}
    );
    AssertVectorEquality(edges4[1], {100, 0, 100, 100});
    AssertVectorEquality(edges4[2], {100, 100, 0, 100});
    AssertVectorEquality(edges4[3], {50, 0, 100, 0});
    AssertVectorEquality(edges4[4], {0, 50, 0, 100});
    AssertVectorEquality(edges4[5], {50, 0, 0, 50});
end test_VoronoiCell;
