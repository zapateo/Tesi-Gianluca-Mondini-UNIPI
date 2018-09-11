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

function debug
  input String message;
algorithm
  print("\n[DEBUG]: " + message + "\n\n");
end debug;

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

//------------------------------------------------------------------------------

record Point
  Real x;
  Real y;
end Point;

//------------------------------------------------------------------------------

function points_are_close
  input Point p1;
  input Point p2;
  output Boolean out;
protected
  parameter Real tolerance = 0.001;
algorithm
  if abs(p1.x - p2.x) < tolerance then
    if abs(p1.y - p2.y) < tolerance then
      out := true;
    else
      out := false;
    end if;
  else
    out := false;
  end if;
end points_are_close;

model test_points_are_close
  parameter Point p1 = Point(0.0, 0.0);
  parameter Point p2 = Point(0.0001, 0.0);
  parameter Point p3 = Point(0.0, 0.0);
  parameter Point p4 = Point(1.0001, 0.0);
equation
  assert(points_are_close(p1, p2), "p1 and p2 should be close");
  assert(not points_are_close(p3, p4), "p3 and p4 should not be close");
end test_points_are_close;

//------------------------------------------------------------------------------

record Edge
  parameter Point starting;
  parameter Point ending;
end Edge;

//------------------------------------------------------------------------------

function edges_are_close
  input Edge e1, e2;
  output Boolean out;
algorithm
  out := points_are_close(e1.starting, e2.starting) and points_are_close(e1.ending, e2.ending);
end edges_are_close;

model test_edges_are_close
  parameter Edge e1 = Edge(Point(4.0, 5.0), Point(1.0, -3.0));
  parameter Edge e2 = Edge(Point(4.0, 5.0), Point(1.0001, -3.0));
  parameter Edge e3 = Edge(Point(-4.0, -5.0), Point(1.0001, -3.0));
equation
  assert(edges_are_close(e1, e2), "e1 and e2 should be close");
  assert(not edges_are_close(e1, e3), "e1 and e3 should not be close");
end test_edges_are_close;

//------------------------------------------------------------------------------

record Cell
  parameter Point drone;
  parameter Edge edges[99];
end Cell;

//------------------------------------------------------------------------------

record Line_abc
  parameter Real a, b, c;
end Line_abc;

//------------------------------------------------------------------------------

function segment_slope
  input Edge edge;
  output Real out;
  output Boolean vertical;
protected
  Real dx, dy;
algorithm
  dx := edge.ending.x - edge.starting.x;
  dy := edge.ending.y - edge.starting.y;
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
  parameter Edge e1 = Edge(Point(0, 0), Point(10, 10));
  parameter Edge e2 = Edge(Point(0, 2), Point(2, 0));
  // Segmenti verticali
  parameter Edge e3 = Edge(Point(1, 10), Point(1, -2));
  parameter Edge e4 = Edge(Point(-5, 10), Point(-5, -2));

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
  input Edge edge;
  output Point out;
protected
  Real xm, ym;
algorithm
  xm := (edge.starting.x + edge.ending.x)/2;
  ym := (edge.starting.y + edge.ending.y)/2;
  out.x := xm;
  out.y := ym;
end midpoint;

model test_midpoint
  parameter Edge e1 = Edge(Point(0, 0), Point(2, 2));
  parameter Edge e2 = Edge(Point(1, 1), Point(4, -5));
  parameter Point p1 = midpoint(e1);
  parameter Point p2 = midpoint(e2);
equation
  assert(p1.x == 1 and p1.y == 1, "midpoint #1");
  assert(p2.x == 2.5 and p2.y == -2.0, "midpoint #2");
end test_midpoint;

//------------------------------------------------------------------------------

function perpendicular_bisector
  input Edge edge;
  output Line_abc out;
protected
  Boolean vertical;
  Point p;
  Real a, b, c, neg_c, m1, m2, q;
algorithm
  p := midpoint(edge);
  (m1, vertical) := segment_slope(edge);
  if vertical then
    neg_c := (edge.starting.y + edge.ending.y)/2;
    out := Line_abc(0, 1, -neg_c);
    return;
  elseif m1 == 0 then
    a := 1;
    b := 0;
    c := -(edge.starting.x + edge.ending.x)/2;
    out := Line_abc(a, b, c);
    return;
  else
    m2 := -1/m1;
    q := - m2 * p.x + p.y;
    out := Line_abc(-m2, 1, -q);
    return;
  end if;
end perpendicular_bisector;

model test_perpendicular_bisector
  parameter Line_abc line1 = perpendicular_bisector(Edge(Point(0, 2), Point(2, 0)));
  parameter Line_abc line2 = perpendicular_bisector(Edge(Point(5, -3), Point(5, 2)));
  parameter Line_abc line3 = perpendicular_bisector(Edge(Point(-15, 2), Point(-15, -3)));
  parameter Line_abc line4 = perpendicular_bisector(Edge(Point(2, 3), Point(4, 3)));
  parameter Line_abc line5 = perpendicular_bisector(Edge(Point(10, 5), Point(10, 35)));
algorithm
  assert(line1.a == -1, "perpendicular bisector");
  assert(line1.b == 1, "perpendicular bisector");
  assert(line1.c == 0, "perpendicular bisector");

  assert(line2.a == 0, "perpendicular bisector");
  assert(line2.b == 1, "perpendicular bisector");
  assert(line2.c == 0.5, "perpendicular bisector");

  assert(line3.a == 0, "perpendicular bisector");
  assert(line3.b == 1, "perpendicular bisector");
  assert(line3.c == 0.5, "perpendicular bisector");

  assert(line4.a == 1, "perpendicular bisector");
  assert(line4.b == 0, "perpendicular bisector");
  assert(line4.c == -3, "perpendicular bisector");

  assert(line5.a == 0, "perpendicular bisector");
  assert(line5.b == 1, "perpendicular bisector");
  assert(line5.c == -20, "perpendicular bisector");

end test_perpendicular_bisector;

//------------------------------------------------------------------------------

function from_line_to_segment
  input Line_abc line;
  output Edge out;
protected
  parameter Real big = 10000;
  Real a, b, c;
  Point p1, p2;
  Real m, q;
  Real y1, y2;
algorithm
  a := line.a;
  b := line.b;
  c := line.c;

  if b == 0 and (not (a == 0)) then // Retta verticale
    p1 := Point(-c, big);
    p2 := Point(-c, -big);
    out := Edge(p1, p2);
    return;
  else
    m := -a/b;
    q := -c/b;
    y1 := m * (-big) + q;
    y2 := m * (+big) + q;
    out := Edge(Point(-big, y1), Point(big, y2));
  end if;
end from_line_to_segment;

model test_from_line_to_segment
  parameter Line_abc line1 = Line_abc(1, 3, -2);
  parameter Edge e1 = from_line_to_segment(line1);
algorithm
  assert(e1.starting.x == -10000, "from_line_to_segment #1");
  assert(e1.starting.y == 3334.0, "from_line_to_segment #2");
  assert(e1.ending.x == 10000, "from_line_to_segment #3");
  assert(compareReal(e1.ending.y, -3332.67), "from_line_to_segment #4"); // FIXME
end test_from_line_to_segment;

//------------------------------------------------------------------------------

function segment_intersection
  input Edge edge1, edge2;
  output Boolean valid;
  output Point out;
protected
  Point pt1, pt2, ptA, ptB;
  Real x1, x2, y1, y2, dx1, dy1, x, y, xB, yB, dx, dy, DET, DETinv, r, s, xi, yi;
  parameter Real DET_TOLERANCE = 0.00000001;
algorithm
  pt1 := Point(edge1.starting.x, edge1.starting.y);
  pt2 := Point(edge1.ending.x, edge1.ending.y);

  ptA := Point(edge2.starting.x, edge2.starting.y);
  ptB := Point(edge2.ending.x, edge2.ending.y);

  x1 := pt1.x;
  y1 := pt1.y;

  x2 := pt2.x;
  y2 := pt2.y;

  dx1 := x2 - x1;
  dy1 := y2 - y1;

  x := ptA.x;
  y := ptA.y;

  xB := ptB.x;
  yB := ptB.y;

  dx := xB - x;
  dy := yB - y;

  DET := (-dx1 * dy + dy1 + dx);
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
    out := Point(xi, yi);
    valid := true;
    return;
  else
    valid := false;
    return;
  end if;
end segment_intersection;


model test_segment_intersection
  Boolean valid;
  Point p;
algorithm

  (valid, p) := segment_intersection(Edge(Point(0, 0), Point(2, 2)), Edge(Point(0, 2), Point(2, 0)));
  assert(valid == true, "segment intersection #1");
  assertRealEqual(p.x, 1);
  assertRealEqual(p.y, 1);

  (valid, p) := segment_intersection(Edge(Point(1, 1), Point(4, -5)),  Edge(Point(2, -3), Point(3, -1)));
  assert(valid == true, "segment intersection #2");
  assertRealEqual(p.x, 2.5);
  assertRealEqual(p.y, -2.0);

  (valid, p) := segment_intersection(Edge(Point(0, 0), Point(0, 10)), Edge(Point(2, 0), Point(2, -10)));
  assert(valid == false, "segment intersection #3");

  (valid, p) := segment_intersection(Edge(Point(-2, 3), Point(3, 3)), Edge(Point(9, 6), Point(9, 2)));
  assert(valid == false, "segment intersection #4");

  (valid, p) := segment_intersection(Edge(Point(0, 1), Point(1, 2)), Edge(Point(2, 2), Point(1, 3)));
  assert(valid == false, "segment intersection #5");

  (valid, p) := segment_intersection(Edge(Point(2, 5), Point(2, -1)), Edge(Point(2, -1), Point(10, -1)));
  assert(valid == true, "segment intersection #6");
  assertRealEqual(p.x, 2);
  assertRealEqual(p.y, -1);

end test_segment_intersection;
