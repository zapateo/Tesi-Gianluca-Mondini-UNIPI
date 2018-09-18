function PerpendicularBisector
    input Real [4] edge;
    output Real [3] out;
protected
    Boolean vertical;
    Real [2] p;
    Real a, b, c, neg_c, m1, m2, q;
algorithm
    p := Midpoint(edge);
    (m1, vertical) := SegmentSlope(edge);
    if vertical then
        neg_c := (edge[2] + edge[4])/2;
        out := {0, 1, -neg_c};
        return;
    elseif m1 == 0 then
        a := 1;
        b := 0;
        c := -(edge[1] + edge[3])/2;
        out := {a, b, c};
        return;
    else
        m2 := -1/m1;
        q := - m2 * p[1] + p[2];
        out := {-m2, 1, -q};
        return;
    end if;
end PerpendicularBisector;
