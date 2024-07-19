/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

model test_CompareVectors
algorithm
    assert(CompareVectors({0,0,0}, {0,0,0,0}) == false, "");
    assert(CompareVectors({1,1}, {1}) == false, "");
    assert(CompareVectors({1,1,1}, {1,1,1}) == true, "");
    assert(CompareVectors({1,1,1}, {1,1,0}) == false, "");
    assert(CompareVectors({-43,0,-43}, {-43,-43,0}) == false, "");
    assert(CompareVectors({-43,0,-43}, {-43,0,-43}) == true, "");
    assert(CompareVectors({-43,0,-42.9999999}, {-43,0,-43}) == true, "");
    assert(CompareVectors({100, 0}, {99.9999999, 0}) == true, "");
end test_CompareVectors;
