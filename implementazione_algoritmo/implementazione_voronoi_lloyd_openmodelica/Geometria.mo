record Point
  parameter Real x;
  parameter Real y;
end Point;

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

record Edge
  parameter Point starting;
  parameter Point ending;
end Edge;

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

record Cell
  parameter Point drone;
  parameter Edge edges[99];
end Cell;

record Line_abc
  parameter Real a, b, c;
end Line_abc;

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
