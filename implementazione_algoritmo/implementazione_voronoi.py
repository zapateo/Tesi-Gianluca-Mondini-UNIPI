import pygame
import sys
import math
from warnings import warn

ENABLED_DEBUG = True

def debug(msg):
    if ENABLED_DEBUG:
        print(f"[DEBUG] {msg}")

# Può essere utile: https://www.cs.hmc.edu/ACM/lectures/convex_hull.html

class Point:
    """
    Un generico punto nello spazio bidimensionale

    Un sito è un particolare tipo di punto che definisce
    il diagramma di Voronoi

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
        return f"Point({self.x}, {self.y})"

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
    def __str__(self):
        return f"Edge_from:{self.start}to:{self.end}"

class Cell:
    """
    Una cella di Voronoi, composta da un sito (= punto caratterizzante il diagramma di Voronoi) e da una lista di bordi
    """
    def __init__(self, site, edges):
        self.site = site
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

def point_to_point_distance(p1, p2):
    """
    Restituisce la distanza tra i punti `p1` e `p2`

    >>> point_to_point_distance(Point(1, 1), Point(2, 2))
    1.4142135623730951

    >>> point_to_point_distance(Point(0, 3), Point(0, -1))
    4.0
    """
    dx = p1.x - p2.x
    dy = p1.y - p2.y
    return math.sqrt(dx**2 + dy**2)

def segment_slope(edge):
    """
    Restituisce il coefficiente angolare del segmento "edge",
    oppure `None` nel caso in cui `edge` sia verticale

    >>> segment_slope(Edge(Point(0, 0), Point(10, 10)))
    1.0
    >>> segment_slope(Edge(Point(0, 2), Point(2, 0)))
    -1.0
    >>> segment_slope(Edge(Point(1, 10), Point(1, -2)))
    """
    dy = edge.end.y - edge.start.y
    dx = edge.end.x - edge.start.x
    if dx == 0:
        return None
    else:
        return dy/dx

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
    """
    p = midpoint(edge)
    m1 = segment_slope(edge)
    if not m1: # edge è verticale
        # a·x + b·y + c = 0
        neg_c = (edge.start.y + edge.end.y)/2
        return Line_abc(0, 1, -neg_c)
    else: # edge non è verticale
        m2 = -1/m1
        q = - m2 * p.x + p.y
        return Line_abc(-m2, 1, -q)

def from_line_to_segment(line):
    """
    Restituisce un segmento che giace sulla retta `line`

    >>> edge = from_line_to_segment(Line_abc(1, 3, -2))
    >>> print(edge.start)
    Point(-1000, 334.0)
    >>> print(edge.end)
    Point(1000, -332.66666666666663)
    """
    big = 1000

    a, b, c = line.a, line.b, line.c

    # Caso in cui la retta sia verticale
    if b == 0 and a != 0:
        raise Exception("[TODO] retta verticale non gestita")

    m = -a/b
    q = -c/b

    f = lambda x: m*x + q

    p1 = Point(-big, f(-big))
    p2 = Point(+big, f(+big))

    return Edge(p1, p2)

def segment_intersection(edge1, edge2):
    """
    Calcola il punto di intersezione tra il segmento `edge1` e `edge2`

    Restituisce None nel caso in cui non esista un punto di intersezione,
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

    # >>> p = segment_intersection(Edge(Point(0, 1), Point(1, 2)), Edge(Point(2, 2), Point(1, 3)))
    # >>> p.x # dovrebbe restituire None
    # >>> p.y
    """

    # TODO: la funzione dovrebbe restituire None nell'ultimo caso di test
    # e invece restituisce un punto..
    >>> segment_intersection(Edge(Point(0, 0), Point(0, 10)), Edge(Point(2, 0), Point(2, -10)))
    >>> segment_intersection(Edge(Point(-2, 3), Point(3, 3)), Edge(Point(9, 6), Point(9, 2)))
    >>> segment_intersection(Edge(Point(0, 1), Point(1, 2)), Edge(Point(2, 2), Point(1, 3)))
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

    if 0 < r < 1 and 0 < s < 1:
        return Point(xi, yi)
    else:
        return None

class Draw:
    @staticmethod
    def edge(e):
        pygame.draw.line(
            screen,
            (0, 0, 0),
            (e.start.x + int(screen_size[0]/2), e.start.y + int(screen_size[1]/2)),
            (e.end.x + int(screen_size[0]/2), e.end.y + int(screen_size[1]/2))
        )
        pygame.display.flip()

    @staticmethod
    def point(p):
        pygame.draw.circle(
            screen,
            (255, 0, 0),
            (p.x + int(screen_size[0]/2), p.y + int(screen_size[1]/2)),
            3
        )
        pygame.display.flip()

    @staticmethod
    def cell(c):
        Draw.point(c.site)
        for edge in c.edges:
            Draw.edge(edge)

def compute_voronoi(S, width, height):
    """
    S: lista di siti che compongono il diagramma di Voronoi
    """
    for site in S:
        assert type(site) == Point
        Draw.point(site)


    # Step 1
    E = [] # lista di bordi, "edges"
    C = [] # lista di celle

    # Step 2
    # Aggiunta di 3 o 4 "punti all'infinito" alla lista C (cells),
    # per delimitare il diagramma
    infinity=3
    C.append(
        Cell(
            Point(-width, -height),
            [
                Edge(Point(0, 0), Point(0, -infinity*height)),
                Edge(Point(0, -infinity*height), Point(-infinity*width, 0)),
                Edge(Point(-infinity*width, 0), Point(0, 0)),
            ]
        )
    )
    C.append(
        Cell(
            Point(width, -height),
            [
                Edge(Point(0, 0), Point(0, -infinity*height)),
                Edge(Point(0, -infinity*height), Point(infinity*width, 0)),
                Edge(Point(infinity*width, 0), Point(0, 0))
            ]
        )
    )
    C.append(
        Cell(
            Point(width, height),
            [
                Edge(Point(0, 0), Point(infinity*width, 0)),
                Edge(Point(infinity*width, 0), Point(0, infinity*height)),
                Edge(Point(0, infinity*height), Point(0, 0)),
            ]
        )
    )
    C.append(
        Cell(
            Point(-width, height),
            [
                Edge(Point(0, 0), Point(0, infinity*height)),
                Edge(Point(0, infinity*height), Point(-infinity*width, 0)),
                Edge(Point(-infinity*width, 0), Point(0, 0)),
            ]
        )
    )

    # Step 3
    for site in S:

        # Step 4
        # Crea una nuova cella "cell", che abbia "site" come suo sito
        cell = Cell(site, [])

        # Step 5
        for c in C:

            # Step 6
            # Trova la bisettrice del segmento che unisce `site` e `c.site` e chiamala `pb`
            pb = perpendicular_bisector(Edge(site, c.site))

            # Step 7
            # Crea una struttura dati X che andrà a contenere i punti critici dell'algoritmo
            X = []

            # Step 8
            # Per ogni edge `e` in `c`
            for e in c.edges:

                # Step 9
                # Calcola la distanza tra il segmento `e` e la linea retta `pb`
                # e_to_pb_distance = lines_distance(
                #     from_segment_to_line(e),
                #     pb
                # )

                # Step 10
                # Se il segmento `e` è sul lato vicino della retta bisettrice `pb` (ovvero se è più vicino al punto `site` rispetto che al punto `c.site`), contrassegna `e` per la cancellazione (oppure cancellalo subito se questo non va a danneggiare l'enumerazione)
                e_site_distance = point_to_point_distance(
                    midpoint(e),
                    site
                )
                e_c_site_distance = point_to_point_distance(
                    midpoint(e),
                    c.site
                )
                if e_site_distance < e_c_site_distance:
                    e.to_be_deleted = True

                # Step 11
                # Se il segmento `e` interseca la retta `pb`, taglia e nel lato più lontano di `pb`, e memorizza il punto di intersezione in X
                e_pb_intersection = segment_intersection(
                    e,
                    from_line_to_segment(pb)
                )
                if e_pb_intersection:
                    X.append(e_pb_intersection)

            # Step 12
            # In questo momento X dovrebbe contenere 0 o 2 punti; se ne ha 2, crea un nuovo Edge che li connetta, e aggiungi questo nuovo `new_edge` a `c`, `cell` e `E`
            if len(X) == 2:
                new_edge = Edge(X[0], X[1])
                c.edges.append(new_edge)
                cell.edges.append(new_edge)
                E.append(new_edge)
            elif len(X) == 0:
                pass
            else:
                warn("X should contain 0 or 2 elements. X: " + ", ".join([str(x) for x in X]))

            # Step 13
            # Se necessario, cancella ogni segmento marcato nello step 10 sia da `c` che da `E`
            E = list(filter(lambda e: not e.to_be_deleted, E))

    for edge in E:
        Draw.edge(edge)
    for cell in C:
        Draw.cell(cell)

screen_size = 800, 600
pygame.init()
screen = pygame.display.set_mode(screen_size)
screen.fill((255, 255, 255))

if __name__ == "__main__":
    import doctest
    doctest.testmod()

    compute_voronoi([Point(-20, -40), Point(0, 20), Point(100, 3), Point(-3, 3)], int(screen_size[0]/4-40), int(screen_size[1]/4-40))

    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                sys.exit()
