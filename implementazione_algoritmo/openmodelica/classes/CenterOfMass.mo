/*
 *    Gianluca Mondini - 2018
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi_GianlucaMondini
 */

function CenterOfMass

    input Real [:, 2] points;

    output Real [2] out;

protected

    Real [:, 2] vertices, v_local;
    Real x_cent, y_cent, area, factor;

algorithm

    if size(points, 1) < 3 then
        out := {-1,-1};
    end if;


    // Adattato da https://stackoverflow.com/a/46937541
    vertices := points;

    x_cent := 0;
    y_cent := 0;
    area := 0;

    v_local := cat(1, vertices, {vertices[1]});

    for i in 1:(size(v_local, 1) - 1) loop
        factor := v_local[i,1] * v_local[i+1, 2] - v_local[i+1,1] * v_local[i,2];
        area := area + factor;
        x_cent := x_cent + (v_local[i, 1] + v_local[i+1,1]) * factor;
        y_cent := y_cent + (v_local[i, 2] + v_local[i+1, 2]) * factor;
    end for;

    area := area / 2.0;
    x_cent := x_cent / (area * 6);
    y_cent := y_cent / (area * 6);

    out := {x_cent, y_cent};

end CenterOfMass;
