/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function VectorToString
    input Real [:] vect;
    output String out;
algorithm
    out := "{";
    for i in 1:size(vect, 1) loop
        out := out + String(vect[i]) + ", ";
    end for;
    out := out + "}";
end VectorToString;
