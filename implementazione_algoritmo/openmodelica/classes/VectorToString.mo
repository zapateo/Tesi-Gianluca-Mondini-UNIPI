/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
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
