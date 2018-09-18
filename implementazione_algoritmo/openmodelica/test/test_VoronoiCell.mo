/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_VoronoiCell
    Real [3, 4] edges1;
    Real [5, 4] edges2;
algorithm
    edges1 := VoronoiCell(
        {{0, 0, 100, 0}, {100, 0, 100, 100}, {100, 100, 0, 100}, {0, 100, 0, 0}},
        {25, 25},
        {{75, 75}}
    );
    AssertVectorEquality(edges1[1], {100, 0, 0, 0});
    AssertVectorEquality(edges1[2], {0, 100, 0, 0});
    AssertVectorEquality(edges1[3], {100, 0, 0, 100});
    //--------------------------------------------------------------------------
    edges2 := VoronoiCell(
        {{100, 0, 300, 0}, {300, 0, 300, 200}, {300, 200, 200, 400}, {200, 400, 0, 200}, {0, 200, 100, 0}},
        {200, 300},
        {{100, 100}, {100, 200}}
    );
    AssertVectorEquality(edges2[1], {300,200,200,400});
    AssertVectorEquality(edges2[2], {300,125,300,200});
    AssertVectorEquality(edges2[3], {100,300,200,400});
    AssertVectorEquality(edges2[4], {250,150,300,125});
    AssertVectorEquality(edges2[5], {100,300,250,150});
end test_VoronoiCell;
