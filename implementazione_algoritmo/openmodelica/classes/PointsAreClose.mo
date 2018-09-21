/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function PointsAreClose
    input Real [2] p1;
    input Real [2] p2;
    output Boolean are_close;
protected
    parameter Real tolerance = 0.001;
algorithm
    if abs(p1[1] - p2[1]) < tolerance then
        if abs(p1[2] - p2[2]) < tolerance then
            are_close := true;
        else
            are_close := false;
        end if;
    else
        are_close := false;
    end if;
end PointsAreClose;
