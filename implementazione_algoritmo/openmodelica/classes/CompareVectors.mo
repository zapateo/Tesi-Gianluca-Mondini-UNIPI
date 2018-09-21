/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function CompareVectors
    input Real [:] vector1, vector2;
    output Boolean equal;
algorithm
    if not (size(vector1, 1) == size(vector2, 1)) then
        equal := false;
        return;
    end if;

    equal := true;
    for i in 1:size(vector1, 1) loop
        if not CompareReal(vector1[i], vector2[i]) then
            equal := false;
        end if;
    end for;
end CompareVectors;
