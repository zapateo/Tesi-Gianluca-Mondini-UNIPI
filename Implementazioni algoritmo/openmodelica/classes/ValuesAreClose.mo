/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function ValuesAreClose
    input Real a, b;
    output Boolean close;
algorithm
    close := (abs(a - b) < 0.001);
end ValuesAreClose;
