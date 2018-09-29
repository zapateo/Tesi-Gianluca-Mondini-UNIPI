/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_MarkUnwantedEdges

    Real [4] in1_1 = {-1, 1, 1, 1};
    Real [4] in1_2 = {-0.5, 3, 0.5, 3};
    Real [2, 4] out1;

algorithm

    out1 := MarkUnwantedEdges(
        {in1_1, in1_2},
        {0,0}
    );
    AssertVectorEquality(out1[1], {-1,1,1,1});
    AssertVectorEquality(out1[2], {-1,-1,-1,-1});

end test_MarkUnwantedEdges;
