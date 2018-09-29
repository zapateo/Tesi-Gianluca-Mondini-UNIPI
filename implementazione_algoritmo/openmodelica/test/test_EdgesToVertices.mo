/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_EdgesToVertices

    Real [4] in1_1 = {0,0,1,1};
    Real [4] in1_2 = {1,1,0,0};
    Real [2,2] out1;

    Real [4,2] out2;

algorithm

    out1 := EdgesToVertices({in1_1, in1_2});
    assert(CompareVectors(out1[1], {0, 0}), "");
    assert(CompareVectors(out1[2], {1, 1}), "");

    out2 := EdgesToVertices({{0,0,1,0}, {1,0,1,1}, {1,1,0,1}, {0,1,0,0}});
    assert(CompareVectors(out2[1], {0, 0}), "");
    assert(CompareVectors(out2[2], {1, 0}), "");
    assert(CompareVectors(out2[3], {1, 1}), "");
    assert(CompareVectors(out2[4], {0, 1}), "");
    
end test_EdgesToVertices;
