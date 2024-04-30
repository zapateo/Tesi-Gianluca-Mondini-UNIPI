/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
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
