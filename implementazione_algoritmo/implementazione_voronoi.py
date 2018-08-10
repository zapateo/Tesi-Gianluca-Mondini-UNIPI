class Point:
    """
    Un generico punto nello spazio bidimensionale

    Un sito è un particolare tipo di punto che definisce
    il diagramma di Voronoi
    """
    def __init__(self, x, y):
        self.x = x
        self.y = y

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
    Restituisce il termine noto del segmento `edge`

    >>> y_intercept_of_segment(Edge(Point(1, 1), Point(2, 2)))
    0.0
    >>> y_intercept_of_segment(Edge(Point(0, 1), Point(1, 2)))
    1.0
    """

    x1 = edge.start.x
    x2 = edge.end.x
    y1 = edge.start.y
    y2 = edge.end.y

    if x2 == x1:
        raise Exception("Unable to compute the y-intercept of a vertical segment")

    q = (x2 * y1 - x1 * y2)/(x2 - x1)
    return q

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
    C.append(
        Cell(
            Point(-width, -height),
            [
                Edge(Point(width/2, height/2), Point(width/2, -10*height)),
                Edge(Point(width/2, -10*height), Point(-10*width, height/2)),
                Edge(Point(-10*width, height/2), Point(width/2, height/2)),
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
            pass

compute_voronoi([Point(-3, -4), Point(0, 2), Point(1, 3), Point(-3, 3)], 10, 20)

if __name__ == "__main__":
    import doctest
    doctest.testmod()
