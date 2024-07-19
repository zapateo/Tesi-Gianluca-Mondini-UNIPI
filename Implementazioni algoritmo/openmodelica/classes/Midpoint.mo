/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function Midpoint
    input Real [4] edge;
    output Real [2] midpoint;
protected
    Real xm, ym;
algorithm
    xm := (edge[1] + edge[3])/2;
    ym := (edge[2] + edge[4])/2;
    midpoint[1] := xm;
    midpoint[2] := ym;
end Midpoint;
