model test_RemoveMarkedEdges

	EdgesArray input1;
	EdgesArray out1;

algorithm

	input1.len := 0;
	input1 := EdgesArrayAppend(input1, {0,0,2,2});
	input1 := EdgesArrayAppend(input1, {-1,-1,-1,-1});
	input1 := EdgesArrayAppend(input1, {1,1,-1,1});
	out1 := RemoveMarkedEdges(input1);

	AssertVectorEquality(out1.elements[1], {0,0,2,2});
	AssertVectorEquality(out1.elements[2], {1,1,-1,1});
	assert(out1.len == 2, "out1.len != 2");

end test_RemoveMarkedEdges;
