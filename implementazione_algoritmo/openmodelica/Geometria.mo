// From https://github.com/modelica/Modelica-Compliance/blob/master/ModelicaCompliance/Util.mo
function compareReal
    "Compares two Reals, and checks if they are close enough to be considered equal."
    input Real a, b;
    input Real absTol = 1e-10 "Absolute tolerance.";
    input Real relTol = 1e-5 "Relative tolerance.";
    output Boolean equal;
protected
    Real diff;
algorithm
    diff := abs(a - b);
    equal := diff < absTol or diff <= max(abs(b), abs(a)) * relTol;
end compareReal;

//------------------------------------------------------------------------------

function debug
    input String message;
algorithm
    print("\n[DEBUG]: " + message + "\n\n");
end debug;

//------------------------------------------------------------------------------

function assertRealEqual
    input Real actual;
    input Real expected;
algorithm
    if compareReal(actual, expected) then
        return;
    else
        print("\nASSERTION ERROR [REAL EQUALITY]: expected " + String(expected) + " but have " + String(actual) + "\n\n");
        return;
    end if;
end assertRealEqual;

//------------------------------------------------------------------------------

function is_included
    input Real a;
    input Real b;
    input Real x;
    output Boolean included;
algorithm
    if compareReal(a, x) then
        included := true;
        return;
    elseif compareReal(b, x) then
        included := true;
        return;
    elseif (a < x) and (x < b) then
        included := true;
        return;
    else
        included := false;
    end if;
end is_included;

model test_is_included
algorithm
    assert(is_included(0, 1, 0.5) == true, "");
    assert(is_included(0, 1, 1.5) == false, "");
    assert(is_included(-10, 10, 1.5) == true, "");
    assert(is_included(-10, 10, -15) == false, "");
    assert(is_included(-10, 10, 0) == true, "");
end test_is_included;

//------------------------------------------------------------------------------

function close_value
    input Real a, b;
    output Boolean close;
algorithm
    close := (abs(a - b) < 0.001);
end close_value;

model test_close_value
algorithm
    assert(close_value(0.00001, 0) == true, "");
    assert(close_value(431.00001, 431) == true, "");
    assert(close_value(-0.00001, 0) == true, "");
    assert(close_value(4320.00001, 4319.9999) == true, "");

    assert(close_value(0.00001, 1) == false, "");
    assert(close_value(-9, -10) == false, "");
    assert(close_value(33, 333) == false, "");
end test_close_value;

//------------------------------------------------------------------------------

function points_are_close
    input Real [2] p1;
    input Real [2] p2;
    output Boolean out;
protected
    parameter Real tolerance = 0.001;
algorithm
    if abs(p1[1] - p2[1]) < tolerance then
        if abs(p1[2] - p2[2]) < tolerance then
            out := true;
        else
            out := false;
        end if;
    else
        out := false;
    end if;
end points_are_close;

model test_points_are_close
    parameter Real [2] p1 = {0.0, 0.0};
    parameter Real [2] p2 = {0.0001, 0.0};
    parameter Real [2] p3 = {0.0, 0.0};
    parameter Real [2] p4 = {1.0001, 0.0};
equation
    assert(points_are_close(p1, p2), "p1 and p2 should be close");
    assert(not points_are_close(p3, p4), "p3 and p4 should not be close");
end test_points_are_close;

//------------------------------------------------------------------------------

function edges_are_close
    input Real [4] e1, e2;
    output Boolean out;
algorithm
    out := points_are_close({e1[1], e1[2]}, {e2[1], e2[2]}) and points_are_close({e1[3], e1[4]}, {e2[3], e2[4]});
end edges_are_close;

model test_edges_are_close
    parameter Real [4] e1 = {4.0, 5.0, 1.0, -3.0};
    parameter Real [4] e2 = {4.0, 5.0, 1.0001, -3.0};
    parameter Real [4] e3 = {-4.0, -5.0, 1.0001, -3.0};
equation
    assert(edges_are_close(e1, e2), "e1 and e2 should be close");
    assert(not edges_are_close(e1, e3), "e1 and e3 should not be close");
end test_edges_are_close;

//------------------------------------------------------------------------------

function segment_slope
    input Real [4] edge;
    output Real out;
    output Boolean vertical;
protected
    Real dx, dy;
algorithm
    dx := edge[3] - edge[1];
    dy := edge[4] - edge[2];
    if compareReal(dx, 0.0) then
        vertical := true;
        out := 0;
        return;
    else
        vertical := false;
        out := dy/dx;
        return;
    end if;
end segment_slope;

model test_segment_slope
    // Segmenti non verticali
    parameter Real [4] e1 = {0, 0, 10, 10};
    parameter Real [4] e2 = {0, 2, 2, 0};
    // Segmenti verticali
    parameter Real [4] e3 = {1, 10, 1, -2};
    parameter Real [4] e4 = {-5, 10, -5, -2};

    Real ss;
    Boolean vertical;
algorithm
    (ss, vertical) := segment_slope(e1);
    assert(compareReal(ss, 1.0), "segment_slope #1");
    assert(vertical == false, "segment_slope #1");

    (ss, vertical) := segment_slope(e2);
    assert(compareReal(ss, -1.0), "segment_slope #2");
    assert(vertical == false, "segment_slope #2");

    (ss, vertical) := segment_slope(e3);
    assert(vertical == true, "segment_slope #3");

    (ss, vertical) := segment_slope(e4);
    assert(vertical == true, "segment_slope #4");
end test_segment_slope;

//------------------------------------------------------------------------------

function midpoint
    input Real [4] edge;
    output Real [2] out;
protected
    Real xm, ym;
algorithm
    xm := (edge[1] + edge[3])/2;
    ym := (edge[2] + edge[4])/2;
    out[1] := xm;
    out[2] := ym;
end midpoint;

model test_midpoint
    parameter Real [4] e1 = {0, 0, 2, 2};
    parameter Real [4] e2 = {1, 1, 4, -5};
    parameter Real [2] p1 = midpoint(e1);
    parameter Real [2] p2 = midpoint(e2);
equation
    assert(p1[1] == 1 and p1[2] == 1, "midpoint #1");
    assert(p2[1] == 2.5 and p2[2] == -2.0, "midpoint #2");
end test_midpoint;

//------------------------------------------------------------------------------

function perpendicular_bisector
    input Real [4] edge;
    output Real [3] out;
protected
    Boolean vertical;
    Real [2] p;
    Real a, b, c, neg_c, m1, m2, q;
algorithm
    p := midpoint(edge);
    (m1, vertical) := segment_slope(edge);
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
end perpendicular_bisector;

model test_perpendicular_bisector
    parameter Real [3] line1 = perpendicular_bisector({0, 2, 2, 0});
    parameter Real [3] line2 = perpendicular_bisector({5, -3, 5, 2});
    parameter Real [3] line3 = perpendicular_bisector({-15, 2, -15, -3});
    parameter Real [3] line4 = perpendicular_bisector({2, 3, 4, 3});
    parameter Real [3] line5 = perpendicular_bisector({10, 5, 10, 35});
algorithm
    assert(line1[1] == -1, "perpendicular bisector");
    assert(line1[2] == 1, "perpendicular bisector");
    assert(line1[3] == 0, "perpendicular bisector");

    assert(line2[1] == 0, "perpendicular bisector");
    assert(line2[2] == 1, "perpendicular bisector");
    assert(line2[3] == 0.5, "perpendicular bisector");

    assert(line3[1] == 0, "perpendicular bisector");
    assert(line3[2] == 1, "perpendicular bisector");
    assert(line3[3] == 0.5, "perpendicular bisector");

    assert(line4[1] == 1, "perpendicular bisector");
    assert(line4[2] == 0, "perpendicular bisector");
    assert(line4[3] == -3, "perpendicular bisector");

    assert(line5[1] == 0, "perpendicular bisector");
    assert(line5[2] == 1, "perpendicular bisector");
    assert(line5[3] == -20, "perpendicular bisector");

end test_perpendicular_bisector;

//------------------------------------------------------------------------------

function from_line_to_segment
    input Real [3] line;
    output Real [4] out;
protected
    parameter Real big = 10000;
    Real a, b, c;
    Real [2] p1, p2;
    Real m, q;
    Real y1, y2;
algorithm
    a := line[1];
    b := line[2];
    c := line[3];

    if b == 0 and (not (a == 0)) then // Retta verticale
        p1 := {-c, big};
        p2 := {-c, -big};
        out := {p1[1], p1[2], p2[1], p2[2]};
        return;
    else
        m := -a/b;
        q := -c/b;
        y1 := m * (-big) + q;
        y2 := m * (+big) + q;
        out := {-big, y1, big, y2};
    end if;
end from_line_to_segment;

model test_from_line_to_segment
    parameter Real [3] line1 = {1, 3, -2};
    parameter Real [4] e1 = from_line_to_segment(line1);
algorithm
    assert(e1[1] == -10000, "from_line_to_segment #1");
    assert(compareReal(e1[2], 3334), "from_line_to_segment #2");
    assert(e1[3] == 10000, "from_line_to_segment #3");
    assert(compareReal(e1[4], -3332.67), "from_line_to_segment #4"); // FIXME
end test_from_line_to_segment;

//------------------------------------------------------------------------------

function segment_intersection
    input Real [4] edge1, edge2;
    output Boolean valid;
    output Real [2] out;
protected
    Real [2] pt1, pt2, ptA, ptB;
    Real x1, x2, y1, y2, dx1, dy1, x, y, xB, yB, dx, dy, DET, DETinv, r, s, xi, yi;
    parameter Real DET_TOLERANCE = 0.00000001;
algorithm
    pt1 := {edge1[1], edge1[2]};
    pt2 := {edge1[3], edge1[4]};

    ptA := {edge2[1], edge2[2]};
    ptB := {edge2[3], edge2[4]};

    x1 := pt1[1];
    y1 := pt1[2];

    x2 := pt2[1];
    y2 := pt2[2];

    dx1 := x2 - x1;
    dy1 := y2 - y1;

    x := ptA[1];
    y := ptA[2];

    xB := ptB[1];
    yB := ptB[2];

    dx := xB - x;
    dy := yB - y;

    DET := ((-dx1 * dy) + (dy1 + dx));
    if abs(DET) < DET_TOLERANCE then
        valid := false;
        return;
    end if;
    DETinv := 1.0/DET;
    r := DETinv * (-dy  * (x-x1) +  dx * (y-y1));
    s := DETinv * (-dy1 * (x-x1) + dx1 * (y-y1));
    xi := (x1 + r*dx1 + x + s*dx)/2.0;
    yi := (y1 + r*dy1 + y + s*dy)/2.0;
    /* if (0 <= r and r <= 1) and (0 <= s and s <= 1) then */
    if (is_included(0, 1, r)) and (is_included(0, 1, s)) then
        out := {xi, yi};
        valid := true;
        return;
    else
        valid := false;
        return;
    end if;
end segment_intersection;


model test_segment_intersection
    Boolean valid;
    Real [2] p;
algorithm

    (valid, p) := segment_intersection({0, 0, 2, 2}, {0, 2, 2, 0});
    assert(valid == true, "segment intersection #1");
    assertRealEqual(p[1], 1);
    assertRealEqual(p[2], 1);

    (valid, p) := segment_intersection({1, 1, 4, -5},  {2, -3, 3, -1});
    assert(valid == true, "segment intersection #2");
    assertRealEqual(p[1], 2.5);
    assertRealEqual(p[2], -2.0);

    (valid, p) := segment_intersection({0, 0, 0, 10}, {2, 0, 2, -10});
    assert(valid == false, "segment intersection #3");

    (valid, p) := segment_intersection({-2, 3, 3, 3}, {9, 6, 9, 2});
    assert(valid == false, "segment intersection #4");

    (valid, p) := segment_intersection({0, 1, 1, 2}, {2, 2, 1, 3});
    assert(valid == false, "segment intersection #5");

    (valid, p) := segment_intersection({2, 5, 2, -1}, {2, -1, 10, -1});
    assert(valid == true, "segment intersection #6");
    assertRealEqual(p[1], 2);
    assertRealEqual(p[2], -1);

    (valid, p) := segment_intersection({-5, 7, -5, -3}, {-5, -3, 21, -3});
    assert(valid == true, "segment intersection #7");
    assertRealEqual(p[1], -5);
    assertRealEqual(p[2], -3);

    (valid, p) := segment_intersection({1, 1, 2, 2}, {1, 2, 2, 1});
    assert(valid == true, "segment intersection #8");
    assertRealEqual(p[1], 1.5);
    assertRealEqual(p[2], 1.5);

end test_segment_intersection;

//------------------------------------------------------------------------------

function remove_duplicated_edges
    input Real[:, 4] edges;
    output Real[:, 4] unique_edges;
protected
    
    Boolean insert;
algorithm
    for i in 1:size(edges, 1) loop
        insert := true;
        for j in 1:size(unique_edges, 1) loop
            if edges_are_close(edges[i], unique_edges[j]) then
                insert := false;
            end if;
            insert := true;
        end for;
        if insert then
            unique_edges := cat(1, unique_edges, edges[i:i]);
        end if;
    end for;
end remove_duplicated_edges;

model test_remove_duplicated_edges
    Real [5, 4] input1;
    Real[:, 4] out1;
equation
    input1 = {
    {0, 0, 1, 1},
    {0, 0, 1, 1},
    {0, 0, 1, 3},
    {-3, 0, 1, 1},
    {-2, 0, 1, 1}
    };
    out1 = remove_duplicated_edges(input1);
end test_remove_duplicated_edges;

//------------------------------------------------------------------------------

function vertices_from_edges
    input Real [:, 4] edges;
    output Real [:, 2] points;
protected
    Boolean add;
algorithm
    for i in 1:size(edges, 1) loop
        point_start := {edges[i,1], edges[i,2]};
        point_end := {edges[i,3], edges[i, 4]};
        add := true;
        for j in 1:size(points, 1) loop
            if points_are_close(point_start, points[j]) then
                add := false;
            elseif points_are_close(point_end, points[j]) then
                add := true;
            end if;
        end for;
    end for;
end vertices_from_edges;
