/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function EdgesToVertices

    input Real [:, 4] edges;

    output Real [:, 2] points;

protected

    Boolean add_p1, add_p2;

    Real [0, 2] empty_points;
    Real [2] p1, p2, point;

algorithm

    points := empty_points;
    for i in 1:size(edges, 1) loop
        if not CompareVectors(edges[i], {-101010, -101010, -101010, -101010}) then
            p1 := {edges[i, 1], edges[i, 2]};
            p2 := {edges[i, 3], edges[i, 4]};
            add_p1 := true;
            add_p2 := true;
            for points_index in 1:size(points, 1) loop
                point := points[points_index];
                if PointsAreClose(p1, point) then
                    add_p1 := false;
                end if;
                if PointsAreClose(p2, point) then
                    add_p2 := false;
                end if;
            end for;
            if add_p1 then
                points := cat(1, points, {p1});
            end if;
            if add_p2 then
                points := cat(1, points, {p2});
            end if;
        end if;
    end for;

end EdgesToVertices;
