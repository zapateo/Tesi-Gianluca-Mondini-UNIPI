/*
 *    Gianluca Mondini - 2024
 *
 *    Tesi Ing. Informatica - Universita di Pisa
 *
 *    https://github.com/zapateo/Tesi-Gianluca-Mondini-UNIPI
 */

function PerpendicularBisector
    input Real [4] edge;
    output Real [3] perp_bisect;
protected
    Boolean vertical;
    Real [2] p;
    Real a, b, c, neg_c, m1, m2, q;
algorithm
    p := Midpoint(edge);
    (m1, vertical) := SegmentSlope(edge);
    if vertical then
        neg_c := (edge[2] + edge[4])/2;
        perp_bisect := {0, 1, -neg_c};
        return;
    elseif m1 == 0 then
        a := 1;
        b := 0;
        c := -(edge[1] + edge[3])/2;
        perp_bisect := {a, b, c};
        return;
    else
        m2 := -1/m1;
        q := - m2 * p[1] + p[2];
        perp_bisect := {-m2, 1, -q};
        return;
    end if;
end PerpendicularBisector;
