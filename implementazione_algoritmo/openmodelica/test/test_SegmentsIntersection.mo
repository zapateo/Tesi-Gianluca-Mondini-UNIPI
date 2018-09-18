/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_SegmentsIntersection
    Boolean valid;
    Real [2] p;
algorithm

    (valid, p) := SegmentsIntersection({0, 0, 2, 2}, {0, 2, 2, 0});
    assert(valid == true, "segment intersection #1");
    AssertRealEquality(p[1], 1);
    AssertRealEquality(p[2], 1);

    (valid, p) := SegmentsIntersection({1, 1, 4, -5},  {2, -3, 3, -1});
    assert(valid == true, "segment intersection #2");
    AssertRealEquality(p[1], 2.5);
    AssertRealEquality(p[2], -2.0);

    (valid, p) := SegmentsIntersection({0, 0, 0, 10}, {2, 0, 2, -10});
    assert(valid == false, "segment intersection #3");

    (valid, p) := SegmentsIntersection({-2, 3, 3, 3}, {9, 6, 9, 2});
    assert(valid == false, "segment intersection #4");

    (valid, p) := SegmentsIntersection({0, 1, 1, 2}, {2, 2, 1, 3});
    assert(valid == false, "segment intersection #5");

    (valid, p) := SegmentsIntersection({2, 5, 2, -1}, {2, -1, 10, -1});
    assert(valid == true, "segment intersection #6");
    AssertRealEquality(p[1], 2);
    AssertRealEquality(p[2], -1);

    (valid, p) := SegmentsIntersection({-5, 7, -5, -3}, {-5, -3, 21, -3});
    assert(valid == true, "segment intersection #7");
    AssertRealEquality(p[1], -5);
    AssertRealEquality(p[2], -3);

    (valid, p) := SegmentsIntersection({1, 1, 2, 2}, {1, 2, 2, 1});
    assert(valid == true, "segment intersection #8");
    AssertRealEquality(p[1], 1.5);
    AssertRealEquality(p[2], 1.5);

end test_SegmentsIntersection;
