/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function RemoveMarkedEdges

    input Real[:,4] edges;

    output Real[100,4] clean_edges;

protected

    Integer output_size;

algorithm

    output_size := 0;
    clean_edges := fill({-101010,-101010,-101010,-101010},100);

    for i in 1:size(edges, 1) loop
        if not CompareVectors(edges[i], {-1, -1, -1, -1}) then
            output_size := output_size +1;
            clean_edges[output_size] := edges[i];
        end if;
    end for;

end RemoveMarkedEdges;
