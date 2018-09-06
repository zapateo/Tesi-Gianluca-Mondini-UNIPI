# Gianluca Mondini - 2018

import math

class Point:
    """
    Un generico punto nello spazio bidimensionale

    Utilizzo:

    >>> p1 = Point(43.3, -11.89)
    >>> p1.x
    43.3
    >>> p1.y
    -11.89
    """
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __str__(self):
        return f"Point({round(self.x, 1)}, {round(self.y, 1)})"

def points_are_close(p1, p2):
    """
    >>> points_are_close(Point(1, 0), Point(1, 0))
    True
    >>> points_are_close(Point(1, 0), Point(1.5, -1))
    False
    >>> points_are_close(Point(43, -3), Point(42.99999, -3.00001))
    True
    """
    tolerance = 0.001
    if abs(p1.x - p2.x) < tolerance:
        if abs(p1.y - p2.y) < tolerance:
            return True
    return False

def edges_are_close(e1, e2):
    return points_are_close(e1.start, e2.start) and points_are_close(e1.end, e2.end)

class Edge:
    """
    Un bordo, composto da un punto iniziale e da un punto finale
    """
    def __init__(self, start, end):
        assert type(start) == Point
        assert type(end) == Point
        self.start = start
        self.end = end
        self.to_be_deleted = False # Usato nell'algoritmo di Voronoi

    def mark_to_be_deleted(self):
        self.to_be_deleted = True

    def __str__(self):
        return f"Edge_from:{self.start}to:{self.end}"

def E(x1, y1, x2, y2):
    return Edge(Point(x1, y1), Point(x2, y2))

class Cell:
    """
    Una cella di Voronoi, composta da un drone e da una lista di bordi
    """
    def __init__(self, drone, edges):
        self.drone = drone
        self.edges = edges

class Line_abc:
    """
    Una linea retta rappresentata nella forma
    ax + by + c = 0
    """
    def __init__(self, a, b, c):
        self.a = a
        self.b = b
        self.c = c

# def point_to_point_distance(p1, p2):
#     """
#     Restituisce la distanza tra i punti `p1` e `p2`
#
#     >>> point_to_point_distance(Point(1, 1), Point(2, 2))
#     1.4142135623730951
#
#     >>> point_to_point_distance(Point(0, 3), Point(0, -1))
#     4.0
#     """
#     dx = p1.x - p2.x
#     dy = p1.y - p2.y
#     return math.sqrt(dx**2 + dy**2)



def perpendicular_bisector(edge):
    """
    Restituisce la linea retta bisettrice di "edge"

    >>> pb = perpendicular_bisector(Edge(Point(0, 2), Point(2, 0)))
    >>> pb.a
    -1.0
    >>> pb.b
    1
    >>> pb.c
    -0.0

    >>> pb = perpendicular_bisector(Edge(Point(5, -3), Point(5, 2)))
    >>> pb.a
    0
    >>> pb.b
    1
    >>> pb.c
    0.5

    >>> pb = perpendicular_bisector(Edge(Point(-15, 2), Point(-15, -3)))
    >>> pb.a
    0
    >>> pb.b
    1
    >>> pb.c
    0.5

    Caso in cui `edge` sia orizzontale (e quindi la bisettrice è verticale)
    >>> pb = perpendicular_bisector(E(2, 3, 4, 3))
    >>> pb.a
    1
    >>> pb.b
    0
    >>> pb.c
    -3.0

    Caso in cui `edge` sia verticale (e quindi la bisettrice è orizzontale)
    >>> pb = perpendicular_bisector(E(10, 5, 10, 35))
    >>> pb.a
    0
    >>> pb.b
    1
    >>> pb.c
    -20.0


    """
    p = midpoint(edge)
    m1 = segment_slope(edge)
    if m1 == None: # edge è verticale
        # a·x + b·y + c = 0
        neg_c = (edge.start.y + edge.end.y)/2
        # raise Exception("qui c'è un problema..")
        return Line_abc(0, 1, -neg_c)
    elif m1 == 0: # edge è orizzontale
        a = 1
        b = 0
        c = -(edge.start.x + edge.end.x)/2
        return Line_abc(a, b, c)
    else: # edge è "obliquo", caso più frequente
        m2 = -1/m1
        q = - m2 * p.x + p.y
        return Line_abc(-m2, 1, -q)

def segment_slope(edge):
    """
    Restituisce il coefficiente angolare del segmento `edge`:

    >>> segment_slope(Edge(Point(0, 0), Point(10, 10)))
    1.0
    >>> segment_slope(Edge(Point(0, 2), Point(2, 0)))
    -1.0

    ..oppure `None` nel caso in cui il segmento sia verticale:

    >>> segment_slope(Edge(Point(1, 10), Point(1, -2)))
    >>> segment_slope(Edge(Point(-5, 10), Point(-5, -2)))
    """
    dy = edge.end.y - edge.start.y
    dx = edge.end.x - edge.start.x
    if dx == 0:
        return None
    else:
        return dy/dx

def midpoint(edge):
    """
    Restituisce il punto medio del segmento "edge"

    >>> p = midpoint(Edge(Point(0, 0), Point(2, 2)))
    >>> p.x
    1.0
    >>> p.y
    1.0

    >>> p = midpoint(Edge(Point(1, 1), Point(4, -5)))
    >>> p.x
    2.5
    >>> p.y
    -2.0
    """
    xm = (edge.start.x + edge.end.x)/2
    ym = (edge.start.y + edge.end.y)/2
    return Point(xm, ym)

def from_line_to_segment(line):
    """
    Restituisce un segmento che giace sulla retta `line`

    >>> edge = from_line_to_segment(Line_abc(1, 3, -2))
    >>> print(edge.start)
    Point(-10000, 3334.0)
    >>> print(edge.end)
    Point(10000, -3332.7)
    """
    big = 10000

    a, b, c = line.a, line.b, line.c

    # Caso in cui la retta sia verticale
    if b == 0 and a != 0:
        # raise Exception("[TODO] retta verticale non gestita")
        p1 = Point(-c, big)
        p2 = Point(-c, -big)
        return Edge(p1, p2)
    else:
        m = -a/b
        q = -c/b

    f = lambda x: m*x + q

    p1 = Point(-big, f(-big))
    p2 = Point(+big, f(+big))

    return Edge(p1, p2)

def segment_intersection(edge1, edge2):
    """
    Calcola il punto di intersezione tra il segmento `edge1` e `edge2`

    Restituisce `None` nel caso in cui non esista un punto di intersezione,
    oppure un oggetto di tipo `Point`

    Adattato dal codice presente su https://www.cs.hmc.edu/ACM/lectures/intersections.html

    >>> i = segment_intersection(Edge(Point(0, 0), Point(2, 2)), Edge(Point(0, 2), Point(2, 0)))
    >>> i.x
    1.0
    >>> i.y
    1.0

    >>> i = segment_intersection(Edge(Point(1, 1), Point(4, -5)), Edge(Point(2, -3), Point(3, -1)))
    >>> i.x
    2.5
    >>> i.y
    -2.0

    Nel caso in cui non è presente alcun punto di intersezione, viene restituito `None`

    >>> segment_intersection(Edge(Point(0, 0), Point(0, 10)), Edge(Point(2, 0), Point(2, -10)))
    >>> segment_intersection(Edge(Point(-2, 3), Point(3, 3)), Edge(Point(9, 6), Point(9, 2)))
    >>> segment_intersection(Edge(Point(0, 1), Point(1, 2)), Edge(Point(2, 2), Point(1, 3)))

    Caso in cui siano gli estremi del segmento ad intersecarsi:

    >>> p = segment_intersection(E(2, 5, 2, -1), E(2, -1, 10, -1))
    >>> p.x
    2.0
    >>> p.y
    -1.0
    """

    DET_TOLERANCE = 0.00000001

    pt1 = (edge1.start.x, edge1.start.y)
    pt2 = (edge1.end.x,   edge1.end.y)

    ptA = (edge2.start.x, edge2.start.y)
    ptB = (edge2.end.x,   edge2.end.y)

    # the first line is pt1 + r*(pt2-pt1)
    # in component form:
    x1, y1 = pt1;   x2, y2 = pt2
    dx1 = x2 - x1;  dy1 = y2 - y1

    # the second line is ptA + s*(ptB-ptA)
    x, y = ptA;   xB, yB = ptB;
    dx = xB - x;  dy = yB - y;

    # we need to find the (typically unique) values of r and s
    # that will satisfy
    #
    # (x1, y1) + r(dx1, dy1) = (x, y) + s(dx, dy)
    #
    # which is the same as
    #
    #    [ dx1  -dx ][ r ] = [ x-x1 ]
    #    [ dy1  -dy ][ s ] = [ y-y1 ]
    #
    # whose solution is
    #
    #    [ r ] = _1_  [  -dy   dx ] [ x-x1 ]
    #    [ s ] = DET  [ -dy1  dx1 ] [ y-y1 ]
    #
    # where DET = (-dx1 * dy + dy1 * dx)
    #
    # if DET is too small, they're parallel
    #
    DET = (-dx1 * dy + dy1 * dx)

    if math.fabs(DET) < DET_TOLERANCE:
        # return (0,0,0,0,0)
        return None

    # now, the determinant should be OK
    DETinv = 1.0/DET

    # find the scalar amount along the "self" segment
    r = DETinv * (-dy  * (x-x1) +  dx * (y-y1))

    # find the scalar amount along the input line
    s = DETinv * (-dy1 * (x-x1) + dx1 * (y-y1))

    # return the average of the two descriptions
    xi = (x1 + r*dx1 + x + s*dx)/2.0
    yi = (y1 + r*dy1 + y + s*dy)/2.0
    # return ( xi, yi, 1, r, s )

    # print(f"r = {r}, s = {s}, xi = {xi}, yi = {yi}")

    if 0 <= r <= 1 and 0 <= s <= 1:
        return Point(xi, yi)
    else:
        return None

# def point_segment_distance(point, edge):
#     """
#     Restituisce la distanza minima tra il punto `point` ed il segmento `edge`
#
#     >>> point_segment_distance(Point(5, 3), Edge(Point(0, 1), Point(5, 1)))
#     2.0
#     >>> point_segment_distance(Point(8, 1), Edge(Point(0, 1), Point(5, 1)))
#     3.0
#     >>> point_segment_distance(Point(0, 1), Edge(Point(0, 1), Point(5, 1)))
#     0.0
#     >>> point_segment_distance(Point(-1, 2), Edge(Point(0, 1), Point(5, 1)))
#     1.4142135623730951
#
#     Nel caso in cui il segmento abbia una lunghezza nulla, restituisce 0.0
#     >>> point_segment_distance(Point(-43, 33.3), Edge(Point(34, -3), Point(34, -3)))
#     0.0
#     """
#
#     # Codice adattato da https://stackoverflow.com/a/49504330
#
#     dx = edge.end.x - edge.start.x
#     dy = edge.end.y - edge.start.y
#     dr2 = float(dx ** 2 + dy ** 2)
#
#     if dr2 == 0:
#         return 0.0
#
#     lerp = ((point.x - edge.start.x) * dx + (point.y - edge.start.y) * dy) / dr2
#     if lerp < 0:
#         lerp = 0
#     elif lerp > 1:
#         lerp = 1
#
#     x = lerp * dx + edge.start.x
#     y = lerp * dy + edge.start.y
#
#     _dx = x - point.x
#     _dy = y - point.y
#     square_dist = _dx ** 2 + _dy ** 2
#
#     return math.sqrt(square_dist)

if __name__ == "__main__":
    import doctest
    doctest.testmod()
