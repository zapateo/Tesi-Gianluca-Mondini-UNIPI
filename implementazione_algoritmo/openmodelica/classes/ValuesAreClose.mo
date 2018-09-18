/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function ValuesAreClose
    input Real a, b;
    output Boolean close;
algorithm
    close := (abs(a - b) < 0.001);
end ValuesAreClose;
