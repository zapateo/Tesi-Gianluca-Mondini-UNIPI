/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_PointsAreClose

    Real [2] p1 = {0.0,       0.0};
    Real [2] p2 = {0.0001,    0.0};
    Real [2] p3 = {0.0,       0.0};
    Real [2] p4 = {1.0001,    0.0};
    Real [2] p5 = {50.0,      -70.0};
    Real [2] p6 = {49.999999, -70.00000001};

equation
    assert(PointsAreClose(p1, p2), "p1 and p2 should be close");
    assert(not PointsAreClose(p3, p4), "p3 and p4 should not be close");
    assert(PointsAreClose(p5, p6), "p5 e p6 dovrebbero essere vicini tra loro");
end test_PointsAreClose;
