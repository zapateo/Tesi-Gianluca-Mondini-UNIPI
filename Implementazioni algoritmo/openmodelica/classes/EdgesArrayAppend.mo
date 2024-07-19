/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function EdgesArrayAppend
    input EdgesArray array;
    input Real [4] new_element;
    output EdgesArray out;
algorithm
    out := array;
    out.len := out.len + 1;
    out.elements[out.len] := new_element;
end EdgesArrayAppend;
