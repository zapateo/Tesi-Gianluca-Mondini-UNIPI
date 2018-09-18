/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_LineToSegment
protected
    parameter Real [3] line1 = {1, 3, -2};
    parameter Real [4] e1 = LineToSegment(line1);
algorithm
    assert(e1[1] == -10000, "LineToSegment #1");
    assert(CompareReal(e1[2], 3334), "LineToSegment #2");
    assert(e1[3] == 10000, "LineToSegment #3");
    assert(CompareReal(e1[4], -3332.67), "LineToSegment #4");
end test_LineToSegment;
