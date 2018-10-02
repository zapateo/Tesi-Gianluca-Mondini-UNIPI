/*
*    Gianluca Mondini - 2018
*
*    Tesi Ing. Informatica - Universita di Pisa
*
*    https://github.com/zapateo/Tesi_GianlucaMondini
*/

function MarkUnwantedEdges

    input  EdgesArray edges;
    input  Real [2]   primary_drone;
    output EdgesArray marked_edges;

protected

    Real [2] point, intersection;
    Real [4] inner_edge, join_edge;
    Boolean valid;

algorithm

    marked_edges.len := 0;
    for i in 1:edges.len loop
        marked_edges := EdgesArrayAppend(marked_edges, edges.elements[i]);
    end for;

    // Scorro tra tutti i bordi
    for outer_i in 1:edges.len loop

        if not CompareVectors(edges.elements[outer_i], {-101010, -101010, -101010, -101010}) then
            // Per ogni bordo, seleziono prima un estremo e poi l'altro
            for point_index in 0:1 loop
                if point_index == 1 then
                    point := {edges.elements[outer_i,1], edges.elements[outer_i,2]};
                else // point_index == 2
                    point := {edges.elements[outer_i,3], edges.elements[outer_i,4]};
                end if;

                // Scorro tutti i bordi e vedo se la congiunzione
                // tra l'estremo trovato e il primary_drone
                // crea una collisione, in tal caso contrassegno il bordo esterno
                // per l'eliminazione
                for inner_edge_index in 1:edges.len loop

                    inner_edge := edges.elements[inner_edge_index];
                    join_edge := {primary_drone[1], primary_drone[2], point[1], point[2]};

                    (valid, intersection) := SegmentsIntersection(inner_edge, join_edge);

                    if valid and (not PointsAreClose(intersection, point)) then
                        marked_edges.elements[outer_i] := {-1, -1, -1, -1};
                    end if;
                end for;
            end for;
        end if;
    end for;

    //out := cat(1, marked_edges, empty_marked_edges);

end MarkUnwantedEdges;
