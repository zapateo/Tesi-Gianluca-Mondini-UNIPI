/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_RemoveDuplicatedEdges

    EdgesArray in1, out1;
    EdgesArray in2, out2;
    EdgesArray in3, out3;

algorithm

    in1.len := 0;
    in1 := EdgesArrayAppend(in1, {0,2,0,4});
    in1 := EdgesArrayAppend(in1, {0,2,0,4});
    in1 := EdgesArrayAppend(in1, {1,10,1,20});
    in1 := EdgesArrayAppend(in1, {5,9,84,1});
    in1 := EdgesArrayAppend(in1, {1,10,1,20});
    out1 := RemoveDuplicatedEdges(in1);
    assert(out1.len == 3, "out1.len != 3");
    AssertVectorEquality(out1.elements[1], {0,2,0,4});
    AssertVectorEquality(out1.elements[2], {1,10,1,20});
    AssertVectorEquality(out1.elements[3], {5,9,84,1});

    in2.len := 0;
    in2 := EdgesArrayAppend(in2, {1,2,3,4});
    in2 := EdgesArrayAppend(in2, {1,2,3,5});
    in2 := EdgesArrayAppend(in2, {1,2,3,4});
    in2 := EdgesArrayAppend(in2, {0,1,2,3});
    out2 := RemoveDuplicatedEdges(in2);
    assert(out2.len == 3, "out2.len != 3");
    AssertVectorEquality(out2.elements[1], {1,2,3,4});
    AssertVectorEquality(out2.elements[2], {1,2,3,5});
    AssertVectorEquality(out2.elements[3], {0,1,2,3});

    in3.len := 0;
    in3 := EdgesArrayAppend(in3, {45,10,8,-3});
    in3 := EdgesArrayAppend(in3, {45,10,8,-3});
    in3 := EdgesArrayAppend(in3, {1,1,0,0});
    in3 := EdgesArrayAppend(in3, {0,0,1,1});
    out3 := RemoveDuplicatedEdges(in3);
    assert(out3.len == 2, "out3.len != 2");
    AssertVectorEquality(out3.elements[1], {45,10,8,-3});
    AssertVectorEquality(out3.elements[2], {1,1,0,0});

end test_RemoveDuplicatedEdges;
