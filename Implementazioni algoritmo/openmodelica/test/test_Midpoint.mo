/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_Midpoint

    Real [4] in1 = {0, 0, 2, 2};

    Real [4] in2 = {1, 1, 4, -5};

algorithm

    AssertVectorEquality(Midpoint(in1), {1, 1});

    AssertVectorEquality(Midpoint(in2), {2.5, -2.0});

end test_Midpoint;
