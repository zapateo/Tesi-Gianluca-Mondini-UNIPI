import pygame
import sys

class Point:
    """
    Un generico punto nello spazio bidimensionale

    Un sito è un particolare tipo di punto che definisce
    il diagramma di Voronoi
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

class Cell:
    """
    Una cella di Voronoi, composta da un sito (= punto caratterizzante il diagramma di Voronoi) e da una lista di bordi
    """
    def __init__(self, site, edges):
        self.site = site
        self.edges = edges

class Line:
    """
    Una linea retta con coefficiente angolare "m" e termine noto "q"
    """
    def __init__(self, m, q):
        self.m = m
        self.q = q

def midpoint(edge):
    """
    Restituisce il punto medio del segmento "edge"

    >>> p = midpoint(Edge(Point(0, 0), Point(2, 2)))
    >>> p.x
    1.0
    >>> p.y
    1.0
    """
    xm = (edge.start.x + edge.end.x)/2
    ym = (edge.start.y + edge.end.y)/2
    return Point(xm, ym)

def segment_slope(edge):
    """
    Restituisce il coefficiente angolare del segmento "edge"

    >>> segment_slope(Edge(Point(0, 0), Point(10, 10)))
    1.0
    >>> segment_slope(Edge(Point(0, 2), Point(2, 0)))
    -1.0
    """
    dy = edge.end.y - edge.start.y
    dx = edge.end.x - edge.start.x
    if dx == 0 and dy > 0:
        return float("inf")
    elif dx == 0 and dy < 0:
        return float("inf")
    elif dx == 0 and dy == 0:
        return float("Nan")
    else:
        return dy/dx

def perpendicular_bisector(edge):
    """
    Restituisce la linea retta bisettrice di "edge"

    >>> pb = perpendicular_bisector(Edge(Point(0, 2), Point(2, 0)))
    >>> pb.m
    1.0
    >>> pb.q
    0.0
    """
    p = midpoint(edge)
    m1 = segment_slope(edge)
    m2 = -1/m1
    q = - m2 * p.x + p.y
    return Line(m2, q)

def y_intercept_of_segment(edge):
    """
    Restituisce il termine noto del segmento `edge`,
    oppure `-9999999` nel caso in cui il segmento sia verticale

    >>> y_intercept_of_segment(Edge(Point(1, 1), Point(2, 2)))
    0.0
    >>> y_intercept_of_segment(Edge(Point(0, 1), Point(1, 2)))
    1.0
    >>> y_intercept_of_segment(Edge(Point(2, 2), Point(2, 50)))
    -9999999
    >>> y_intercept_of_segment(Edge(Point(-2, -4), Point(-2, 22)))
    -9999999
    """

    x1 = edge.start.x
    x2 = edge.end.x
    y1 = edge.start.y
    y2 = edge.end.y

    if x2 == x1:
        # raise Exception("Unable to compute the y-intercept of a vertical segment")
        # return float("NaN")
        return -9999999

    q = (x2 * y1 - x1 * y2)/(x2 - x1)
    return q

def lines_intersection(line1, line2):
    """
    Se `line1` e `line2` hanno un punto di intersezione restituisce un oggetto di tipo Point, altrimenti None

    >>> p = lines_intersection(Line(1, 0), Line(-1, 1))
    >>> p.x
    0.5
    >>> p.y
    0.5
    """
    # From https://en.wikipedia.org/wiki/Line%E2%80%93line_intersection#Given_the_equations_of_the_lines
    a = line1.m
    c = line1.q
    b = line2.m
    d = line2.q

    if (a - b) == 0:
        return None

    x = (d - c)/(a - b)
    y = a * x + c
    return Point(x, y)

def from_segment_to_line(edge):
    """
    Restituisce la retta associata al segmento `edge`
    """
    m = segment_slope(edge)
    q = y_intercept_of_segment(edge)
    return Line(m, q)

def lines_distance(line1, line2):
    if line1.m != line2.m:
        return 0
    else:
        return abs(line1.q - line2.q)

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
                e_to_pb_distance = lines_distance(
                    from_segment_to_line(e),
                    pb
                )

                # Step 10
                pass

                # Step 11
                # Se il segmento `e` interseca la retta `pb`, taglia e nel lato più lontano di `pb`, e memorizza il punto di intersezione in X
                X.append(
                    lines_intersection(
                        from_segment_to_line(e),
                        pb
                    )
                )

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
                raise Exception("X should contain 0 or 2 elements. X: " + ", ".join([str(x) for x in X]))

            # Step 13
            # Se necessario, cancella ogni segmento marcato nello step 10 sia da `c` che da `E`

    screen.fill((255, 255, 255))
    for edge in E:
        Draw.edge(edge)
    for cell in C:
        Draw.cell(cell)


screen_size = 800, 600
pygame.init()
screen = pygame.display.set_mode(screen_size)

if __name__ == "__main__":
    import doctest
    doctest.testmod()

    compute_voronoi([Point(-3, -4), Point(0, 2), Point(1, 3), Point(-3, 3)], int(screen_size[0]/4-40), int(screen_size[1]/4-40))

    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                sys.exit()
