/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_RemoveDuplicatedEdges

    Real [4] in1_1 = {0,2,0,4};
    Real [4] in1_2 = {0,2,0,4};
    Real [4] in1_3 = {1,10,1,20};
    
    Real [2,4] out1;
    //Real [3,4] out2;
    //Real [2,4] out3;

algorithm

    out1 := RemoveDuplicatedEdges({in1_1, in1_2, in1_3});
    AssertVectorEquality(out1[1], {0,2,0,4});
    AssertVectorEquality(out1[2], {1,10,1,20});

    //out2 := RemoveDuplicatedEdges({{1,2,3,4}, {1,2,3,5}, {1,2,3,4}, {0,1,2,3}});
    //AssertVectorEquality(out2[1], {1,2,3,4});
    //AssertVectorEquality(out2[2], {1,2,3,5});
    //AssertVectorEquality(out2[3], {0,1,2,3});

    //out3 := RemoveDuplicatedEdges({{45,10,8,-3}, {45,10,8,-3}, {1,1,0,0}, {0,0,1,1}});
    //AssertVectorEquality(out3[1], {45,10,8,-3});
    //AssertVectorEquality(out3[2], {1,1,0,0});

end test_RemoveDuplicatedEdges;
