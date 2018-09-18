/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Università di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function PointsAreClose
    input Real [2] p1;
    input Real [2] p2;
    output Boolean out;
protected
    parameter Real tolerance = 0.001;
algorithm
    if abs(p1[1] - p2[1]) < tolerance then
        if abs(p1[2] - p2[2]) < tolerance then
            out := true;
        else
            out := false;
        end if;
    else
        out := false;
    end if;
end PointsAreClose;
