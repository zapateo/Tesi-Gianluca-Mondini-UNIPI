/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_Midpoint
protected
    parameter Real [4] e1 = {0, 0, 2, 2};
    parameter Real [4] e2 = {1, 1, 4, -5};
    parameter Real [2] p1 = Midpoint(e1);
    parameter Real [2] p2 = Midpoint(e2);
equation
    assert(p1[1] == 1 and p1[2] == 1, "Midpoint #1");
    assert(p2[1] == 2.5 and p2[2] == -2.0, "Midpoint #2");
end test_Midpoint;
