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

function point_to_point_distance
  input Point p1, p2;
  output Real distance;
algorithm
  distance := sqrt((p1.x-p2.x)^2 + (p1.y-p2.y)^2);
end point_to_point_distance;

model test_point_to_point_distance
  parameter Point p1 = Point(0, 0);
  parameter Point p2 = Point(3, 4);
equation
  assert(point_to_point_distance(p1, p2) == 5, "distance from p1 to p2 should be 5");
end test_point_to_point_distance;

//------------------------------------------------------------------------------

function perpendicular_bisector
  input Edge edge;
  output Line_abc out;
algorithm
  // TODO
end perpendicular_bisector;

//------------------------------------------------------------------------------

function segment_slope
  input Edge edge;
  output Real out;
  /* output Boolean valid; */
protected
  Real dx, dy;
algorithm
  dx := edge.ending.y - edge.starting.y;
  dy := edge.ending.x - edge.starting.x;
  if dx == 0 then
    // FIXME
    out := 99999999;
    return;
    /* valid := false; */
  else
    /* valid := true; */
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
  /* Boolean valid; */
equation
  assert(segment_slope(e1) == 1.0, "segment_slope #1");
  assert(segment_slope(e2) == -1.0, "segment_slope #2");
  /* assert(segment_slope(e3) == 99999999, "segment_slope #3"); */
  /* assert(segment_slope(e4) == 99999999, "segment_slope #4"); */
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

function from_line_to_segment
  input Line_abc line;
  output Edge out;
protected
  parameter Real big = 10000;
  Real a, b, c;
  Point p1, p2;
  Real m, q;
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
  end if;
end from_line_to_segment;

model test_from_line_to_segment
  Line_abc line1 = Line_abc(1, 3, -2);
  Edge e1;
equation
  e1 = from_line_to_segment(line1);
  assert(e1.starting.x == -10000, "from_line_to_segment #1");
  assert(e1.starting.y == 3334.0, "from_line_to_segment #2");
  assert(e1.ending.x == 10000, "from_line_to_segment #3");
  assert(e1.ending.y == -3332.7, "from_line_to_segment #4");
end test_from_line_to_segment;

//------------------------------------------------------------------------------

function segment_intersection
  input Edge edge1, edge2;
  output Point p1;
protected
  parameter Real DET_TOLERANCE = 0.00000001;
  Point pt1, pt2, ptA, ptB;
  Real x1, x2, y1, y2, dx1, dy1, x, y, xB, yB, dx, dy;
algorithm
  pt1 := (edge1.starting.x, edge1.starting.y);
  pt2 := (edge1.ending.x, edge1.ending.y);

  ptA := (edge2.starting.x, edge2.starting.y);
  ptB := (edge2.ending.x, edge2.ending.y);

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
  if math.fabs(DET) < DET_TOLERANCE then
    out := None; // FIXME
  end if;
  DETinv := 1.0/DET;
  r := DETinv * (-dy  * (x-x1) +  dx * (y-y1));
  s := DETinv * (-dy1 * (x-x1) + dx1 * (y-y1));
  xi := (x1 + r*dx1 + x + s*dx)/2.0;
  yi := (y1 + r*dy1 + y + s*dy)/2.0;
  if (0 <= r <= 1) and (0 <= s <= 1) then
    out := Point(xi, yi);
  else
    out := None;
  end if;
end segment_intersection;
