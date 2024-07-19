/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function PointsArrayAppend
    input PointsArray array;
    input Real [2] new_element;
    output PointsArray out;
algorithm
    out := array;
    out.len := out.len + 1;
    out.elements[out.len] := new_element;
end PointsArrayAppend;
