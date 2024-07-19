/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function AssertVectorEquality

    input Real [:] actual, expected;

algorithm

    if not CompareVectors(actual, expected) then
        print("\nASSERTION ERROR [VECTOR EQUALITY]: expected " + VectorToString(expected) + " but have " + VectorToString(actual) + "\n\n");
    end if;
    
end AssertVectorEquality;
