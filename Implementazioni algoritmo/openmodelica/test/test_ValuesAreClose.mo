/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_ValuesAreClose
algorithm
    assert(ValuesAreClose(0.00001, 0) == true, "");
    assert(ValuesAreClose(431.00001, 431) == true, "");
    assert(ValuesAreClose(-0.00001, 0) == true, "");
    assert(ValuesAreClose(4320.00001, 4319.9999) == true, "");

    assert(ValuesAreClose(0.00001, 1) == false, "");
    assert(ValuesAreClose(-9, -10) == false, "");
    assert(ValuesAreClose(33, 333) == false, "");
end test_ValuesAreClose;
