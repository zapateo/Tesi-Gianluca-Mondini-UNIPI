/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_MarkUnwantedEdges

    EdgesArray in1;
    EdgesArray out1;

algorithm

    in1.len := 0;
    in1 := EdgesArrayAppend(in1, {-1, 1, 1, 1});
    in1 := EdgesArrayAppend(in1, {-0.5, 3, 0.5, 3});

    out1 := MarkUnwantedEdges(
        in1,
        {0,0}
    );
    AssertVectorEquality(out1.elements[1], {-1,1,1,1});
    AssertVectorEquality(out1.elements[2], {-1,-1,-1,-1});

end test_MarkUnwantedEdges;
