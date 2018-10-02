model test_RemoveMarkedEdges

	Real [3,4] input1 = {{0,0,2,2}, {-1,-1,-1,-1}, {1,1,-1,1}};
	Real [100,4] out1;

algorithm

	out1 := RemoveMarkedEdges(input1);
	AssertVectorEquality(out1[1], {0,0,2,2});
	AssertVectorEquality(out1[2], {1,1,-1,1});

end test_RemoveMarkedEdges;
