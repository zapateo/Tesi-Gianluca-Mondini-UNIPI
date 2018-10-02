/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function RemoveDuplicatedEdges

    input Real[:, 4] edges;

    output Real[100, 4] unique_edges;
    
protected

    Boolean insert;
    Integer output_size;

algorithm

    unique_edges := fill({-2.0,-2.0,-2.0,-2.0},100);
    output_size := 0;

    for i in 1:size(edges, 1) loop

        insert := true;
        for j in 1:output_size loop
            if EdgesAreClose(edges[i], unique_edges[j]) then
                insert := false;
            end if;
        end for;

        if insert then
            output_size := output_size + 1;
            unique_edges[output_size] := edges[i];
        end if;
    end for;

end RemoveDuplicatedEdges;
