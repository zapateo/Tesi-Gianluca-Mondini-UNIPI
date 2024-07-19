/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

model test_IsIncluded

algorithm

    assert(IsIncluded(0, 1, 0.5)    == true, "");
    assert(IsIncluded(0, 1, 1.5)    == false, "");
    assert(IsIncluded(-10, 10, 1.5) == true, "");
    assert(IsIncluded(-10, 10, -15) == false, "");
    assert(IsIncluded(-10, 10, 0)   == true, "");

end test_IsIncluded;
