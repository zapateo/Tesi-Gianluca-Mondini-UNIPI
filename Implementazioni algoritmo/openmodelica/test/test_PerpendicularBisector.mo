/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_PerpendicularBisector
protected
    parameter Real [3] line1 = PerpendicularBisector({0, 2, 2, 0});
    parameter Real [3] line2 = PerpendicularBisector({5, -3, 5, 2});
    parameter Real [3] line3 = PerpendicularBisector({-15, 2, -15, -3});
    parameter Real [3] line4 = PerpendicularBisector({2, 3, 4, 3});
    parameter Real [3] line5 = PerpendicularBisector({10, 5, 10, 35});
algorithm
    assert(line1[1] == -1, "perpendicular bisector");
    assert(line1[2] == 1, "perpendicular bisector");
    assert(line1[3] == 0, "perpendicular bisector");

    assert(line2[1] == 0, "perpendicular bisector");
    assert(line2[2] == 1, "perpendicular bisector");
    assert(line2[3] == 0.5, "perpendicular bisector");

    assert(line3[1] == 0, "perpendicular bisector");
    assert(line3[2] == 1, "perpendicular bisector");
    assert(line3[3] == 0.5, "perpendicular bisector");

    assert(line4[1] == 1, "perpendicular bisector");
    assert(line4[2] == 0, "perpendicular bisector");
    assert(line4[3] == -3, "perpendicular bisector");

    assert(line5[1] == 0, "perpendicular bisector");
    assert(line5[2] == 1, "perpendicular bisector");
    assert(line5[3] == -20, "perpendicular bisector");

end test_PerpendicularBisector;
