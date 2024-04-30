/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_SegmentSlope
protected
    parameter Real [4] e1 = {0, 0, 10, 10};
    parameter Real [4] e2 = {0, 2, 2, 0};
    parameter Real [4] e3 = {1, 10, 1, -2};
    parameter Real [4] e4 = {-5, 10, -5, -2};

    Real ss;
    Boolean vertical;
algorithm
    (ss, vertical) := SegmentSlope(e1);
    assert(CompareReal(ss, 1.0), "SegmentSlope #1");
    assert(vertical == false, "SegmentSlope #1");

    (ss, vertical) := SegmentSlope(e2);
    assert(CompareReal(ss, -1.0), "SegmentSlope #2");
    assert(vertical == false, "SegmentSlope #2");

    (ss, vertical) := SegmentSlope(e3);
    assert(vertical == true, "SegmentSlope #3");

    (ss, vertical) := SegmentSlope(e4);
    assert(vertical == true, "SegmentSlope #4");
end test_SegmentSlope;
