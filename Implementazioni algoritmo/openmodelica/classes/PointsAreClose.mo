/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function PointsAreClose
    input Real [2] p1;
    input Real [2] p2;
    output Boolean are_close;
algorithm
    if ValuesAreClose(p1[1], p2[1]) then
        if ValuesAreClose(p1[2], p2[2]) then
            are_close := true;
        else
            are_close := false;
        end if;
    else
        are_close := false;
    end if;
end PointsAreClose;
