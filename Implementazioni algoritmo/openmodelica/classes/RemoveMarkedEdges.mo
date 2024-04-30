/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function RemoveMarkedEdges

    input EdgesArray edges;
    output EdgesArray clean_edges;

algorithm

    clean_edges.len := 0;

    for i in 1:edges.len loop
        if not CompareVectors(edges.elements[i], {-1, -1, -1, -1}) then
            clean_edges := EdgesArrayAppend(clean_edges, edges.elements[i]);
        end if;
    end for;

end RemoveMarkedEdges;
