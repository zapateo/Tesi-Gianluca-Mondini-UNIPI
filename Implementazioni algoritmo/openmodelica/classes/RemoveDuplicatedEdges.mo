/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function RemoveDuplicatedEdges

    input EdgesArray edges;
    output EdgesArray unique_edges;

protected

    Boolean insert;

algorithm

    unique_edges.len := 0;

    for i in 1:edges.len loop

        insert := true;
        for j in 1:unique_edges.len loop
            if EdgesAreClose(edges.elements[i], unique_edges.elements[j]) then
                insert := false;
            end if;
        end for;

        if insert then
            unique_edges := EdgesArrayAppend(unique_edges, edges.elements[i]);
        end if;
    end for;

end RemoveDuplicatedEdges;
