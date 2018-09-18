/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_MarkUnwantedEdges
    Real [2, 4] out1;
algorithm
    out1 := MarkUnwantedEdges(
        {{-1, 1, 1, 1}, {-0.5, 3, 0.5, 3}},
        {0,0}
    );
    assert(CompareVectors(out1[1], {-1,1,1,1}), "");
    assert(CompareVectors(out1[2], {-1,-1,-1,-1}), "");
end test_MarkUnwantedEdges;
