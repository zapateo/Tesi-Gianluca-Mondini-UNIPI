function MarkUnwantedEdges
    input  Real [:,4] edges;
    input  Real [2]   primary_drone;
    output Real [:,4] marked_edges;
protected
    Real [0,4] empty_marked_edges;
    Real [2] point, intersection;
    Real [4] inner_edge, join_edge;
    Boolean valid;
algorithm
    marked_edges := edges;
    for outer_i in 1:size(edges, 1) loop
        for point_index in 1:2 loop
            if point_index == 1 then
                point := {edges[outer_i,1], edges[outer_i,2]};
            elseif point_index == 2 then
                point := {edges[outer_i,3], edges[outer_i,4]};
            end if;
            for inner_edge_index in 1:size(edges, 1) loop
                inner_edge := edges[inner_edge_index];
                join_edge := {primary_drone[1], primary_drone[2], point[1], point[2]};
                (valid, intersection) := SegmentsIntersection(inner_edge, join_edge);
                if valid and (not PointsAreClose(intersection, point)) then
                    marked_edges[outer_i] := {-1, -1, -1, -1};
                else
                end if;
            end for;
        end for;
    end for;
end MarkUnwantedEdges;
