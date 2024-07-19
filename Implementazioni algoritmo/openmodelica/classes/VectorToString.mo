/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function VectorToString
    input Real [:] vect;
    output String string;
algorithm
    string := "{";
    for i in 1:size(vect, 1) loop
        string := string + String(vect[i]) + ", ";
    end for;
    string := string + "}";
end VectorToString;
