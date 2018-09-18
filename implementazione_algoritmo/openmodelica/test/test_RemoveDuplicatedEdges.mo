model test_RemoveDuplicatedEdges
    Real [2,4] out1;
    Real [3,4] out2;
algorithm
    out1 := RemoveDuplicatedEdges({{0,0,0,0}, {0,0,0,0}, {1,1,1,1}});
    assert(size(out1, 1) == 2, "");
    assert(CompareVectors(out1[1], {0,0,0,0}), "");
    assert(CompareVectors(out1[2], {1,1,1,1}), "");

    out2 := RemoveDuplicatedEdges({{1,2,3,4}, {1,2,3,5}, {1,2,3,4}, {0,1,2,3}});
    assert(size(out2, 1) == 3, "");
    assert(CompareVectors(out2[1], {1,2,3,4}), "");
    assert(CompareVectors(out2[2], {1,2,3,5}), "");
    assert(CompareVectors(out2[3], {0,1,2,3}), "");
end test_RemoveDuplicatedEdges;
