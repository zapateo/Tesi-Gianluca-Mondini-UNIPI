/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_RemoveDuplicatedEdges

    EdgesArray in1;
    EdgesArray out1;

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

    //out2 := RemoveDuplicatedEdges({{1,2,3,4}, {1,2,3,5}, {1,2,3,4}, {0,1,2,3}});
    //AssertVectorEquality(out2[1], {1,2,3,4});
    //AssertVectorEquality(out2[2], {1,2,3,5});
    //AssertVectorEquality(out2[3], {0,1,2,3});

    //out3 := RemoveDuplicatedEdges({{45,10,8,-3}, {45,10,8,-3}, {1,1,0,0}, {0,0,1,1}});
    //AssertVectorEquality(out3[1], {45,10,8,-3});
    //AssertVectorEquality(out3[2], {1,1,0,0});

end test_RemoveDuplicatedEdges;
