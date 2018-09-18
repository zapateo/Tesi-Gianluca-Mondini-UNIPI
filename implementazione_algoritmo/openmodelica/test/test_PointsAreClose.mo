/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_PointsAreClose
protected
    parameter Real [2] p1 = {0.0, 0.0};
    parameter Real [2] p2 = {0.0001, 0.0};
    parameter Real [2] p3 = {0.0, 0.0};
    parameter Real [2] p4 = {1.0001, 0.0};
equation
    assert(PointsAreClose(p1, p2), "p1 and p2 should be close");
    assert(not PointsAreClose(p3, p4), "p3 and p4 should not be close");
end test_PointsAreClose;
