/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

model test_LineToSegment

    Real [3] in1 = {1, 3, -2};

algorithm

    AssertVectorEquality(LineToSegment(in1), {-10000, 3334, 10000, -3332.67});

end test_LineToSegment;
