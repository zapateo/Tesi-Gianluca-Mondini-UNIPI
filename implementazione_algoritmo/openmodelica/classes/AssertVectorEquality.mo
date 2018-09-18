/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function AssertVectorEquality
    input Real [:] actual, expected;
algorithm
    if CompareVectors(actual, expected) then
        return;
    else
        print("\nASSERTION ERROR [VECTOR EQUALITY]: expected " + VectorToString(expected) + " but have " + VectorToString(actual) + "\n\n");
    end if;
end AssertVectorEquality;
