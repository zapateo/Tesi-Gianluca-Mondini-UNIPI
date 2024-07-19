/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

model test_EdgesToVertices

    EdgesArray in1;
    PointsArray out1;

    EdgesArray in2;
    PointsArray out2;

    EdgesArray in3;
    PointsArray out3;

algorithm

    in1.len := 0;
    in1 := EdgesArrayAppend(in1, {0,0,1,1});
    in1 := EdgesArrayAppend(in1, {1,1,0,0});
    out1 := EdgesToVertices(in1);
    assert(out1.len == 2, "out1.len != 2, out1.len == " + String(out1.len));
    AssertVectorEquality(out1.elements[1], {1, 1});
    AssertVectorEquality(out1.elements[2], {0, 0});

    in2.len := 0;
    in2 := EdgesArrayAppend(in2, {0,0,1,0});
    in2 := EdgesArrayAppend(in2, {1,1,0,1});
    in2 := EdgesArrayAppend(in2, {1,0,1,1});
    in2 := EdgesArrayAppend(in2, {0,1,0,0});
    out2 := EdgesToVertices(in2);
    assert(out2.len == 4, "out2.len != 4, out2.len == " + String(out2.len));
    AssertVectorEquality(out2.elements[1], {1, 0});
    AssertVectorEquality(out2.elements[2], {1, 1});
    AssertVectorEquality(out2.elements[3], {0, 1});
    AssertVectorEquality(out2.elements[4], {0, 0});

    in3.len := 0;
    in3 := EdgesArrayAppend(in3, {48, 0, 100, 0});
    in3 := EdgesArrayAppend(in3, {0, 48, 0, 100});
    in3 := EdgesArrayAppend(in3, {48, 0, 0, 48});
    in3 := EdgesArrayAppend(in3, {100, 1, 100, 0});
    in3 := EdgesArrayAppend(in3, {1, 100, 0, 100});
    in3 := EdgesArrayAppend(in3, {100, 1, 1, 100});
    out3 := EdgesToVertices(in3);
    assert(out3.len == 6, "out3.len != 6, out3.len == " + String(out3.len));
    AssertVectorEquality(out3.elements[1], {48, 0});
    AssertVectorEquality(out3.elements[2], {0, 48});
    AssertVectorEquality(out3.elements[3], {0, 100});
    AssertVectorEquality(out3.elements[4], {1, 100});
    AssertVectorEquality(out3.elements[5], {100, 1});
    AssertVectorEquality(out3.elements[6], {100, 0});

end test_EdgesToVertices;
