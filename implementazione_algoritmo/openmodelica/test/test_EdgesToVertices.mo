/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_EdgesToVertices

    EdgesArray in1;
    PointsArray out1;

    EdgesArray in2;
    PointsArray out2;

algorithm

    in1.len := 0;
    in1 := EdgesArrayAppend(in1, {0,0,1,1});
    in1 := EdgesArrayAppend(in1, {1,1,0,0});
    out1 := EdgesToVertices(in1);
    assert(CompareVectors(out1.elements[1], {0, 0}), "");
    assert(CompareVectors(out1.elements[2], {1, 1}), "");

    in2.len := 0;
    in2 := EdgesArrayAppend(in2, {0,0,1,0});
    in2 := EdgesArrayAppend(in2, {1,0,1,1});
    in2 := EdgesArrayAppend(in2, {1,1,0,1});
    in2 := EdgesArrayAppend(in2, {0,1,0,0});
    out2 := EdgesToVertices(in2);
    assert(CompareVectors(out2.elements[1], {0, 0}), "");
    assert(CompareVectors(out2.elements[2], {1, 0}), "");
    assert(CompareVectors(out2.elements[3], {1, 1}), "");
    assert(CompareVectors(out2.elements[4], {0, 1}), "");

end test_EdgesToVertices;
