/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

model test_LineToSegment

    Real [3] in1 = {1, 3, -2};

algorithm

    AssertVectorEquality(LineToSegment(in1), {-10000, 3334, 10000, -3332.67});

end test_LineToSegment;
