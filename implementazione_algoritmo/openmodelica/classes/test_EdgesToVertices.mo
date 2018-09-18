model test_EdgesToVertices
    Real [2,2] list1;
    Real [4,2] list2;
algorithm
    list1 := EdgesToVertices({{0,0,1,1}, {1,1,0,0}});
    assert(CompareVectors(list1[1], {0, 0}), "");
    assert(CompareVectors(list1[2], {1, 1}), "");

    list2 := EdgesToVertices({{0,0,1,0}, {1,0,1,1}, {1,1,0,1}, {0,1,0,0}});
    assert(CompareVectors(list2[1], {0, 0}), "");
    assert(CompareVectors(list2[2], {1, 0}), "");
    assert(CompareVectors(list2[3], {1, 1}), "");
    assert(CompareVectors(list2[4], {0, 1}), "");
end test_EdgesToVertices;
