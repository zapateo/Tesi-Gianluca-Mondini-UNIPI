/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function AssertRealEquality

    input Real actual, expected;

algorithm

    if not CompareReal(actual, expected) then
        print("\nASSERTION ERROR [REAL EQUALITY]: expected " + String(expected) + " but have " + String(actual) + "\n\n");
    end if;

end AssertRealEquality;
