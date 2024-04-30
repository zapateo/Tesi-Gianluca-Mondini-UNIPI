/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
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
