/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function RemoveMarkedEdges

    input Real[:,4] edges;

    output Real [:,4] clean_edges;

protected

    Real [0,4] empty_clean_edges;

algorithm

    clean_edges := empty_clean_edges;
    for i in 1:size(edges, 1) loop
        if not CompareVectors(edges[i], {-1, -1, -1, -1}) then
            clean_edges := cat(1, clean_edges, {edges[i]});
        end if;
    end for;
    
end RemoveMarkedEdges;
