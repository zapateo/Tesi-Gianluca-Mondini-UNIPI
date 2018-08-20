import pygame
import sys
from warnings import warn

from geometria import *

ENABLED_DEBUG = True

def debug(msg):
    if ENABLED_DEBUG:
        print(f"[DEBUG] {msg}")

# Può essere utile: https://www.cs.hmc.edu/ACM/lectures/convex_hull.html

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


    # NOTE: Step 1
    E = [] # lista di bordi, "edges"
    C = [] # lista di celle

    # NOTE: Step 2
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

    # NOTE: Step 3
    debug(f"'for site in S' is going to iterate {len(S)} times")
    for site in S:

        # NOTE: Step 4
        # Crea una nuova cella "cell", che abbia "site" come suo sito
        cell = Cell(site, [])

        # NOTE: Step 5
        debug(f"'for c in C' is going to iterate {len(C)} times")
        for c in C:

            # NOTE: Step 6
            # Trova la bisettrice del segmento che unisce `site` e `c.site` e chiamala `pb`
            pb = perpendicular_bisector(Edge(site, c.site))
            assert any([pb.a != 0, pb.b != 0, pb.c != 0])

            # NOTE: Step 7
            # Crea una struttura dati X che andrà a contenere i punti critici dell'algoritmo
            X = []

            # NOTE: Step 8
            # Per ogni edge `e` in `c`
            debug(f"'for e in c.edges' is going to iterate {len(c.edges)} times")
            for e in c.edges:

                # NOTE: Step 9
                # Calcola la distanza tra il segmento `e` e la linea retta `pb`
                # e_to_pb_distance = lines_distance(
                #     from_segment_to_line(e),
                #     pb
                # )

                # NOTE: Step 10
                # Se il segmento `e` è sul lato vicino della retta bisettrice `pb` (ovvero se è più vicino al punto `site` rispetto che al punto `c.site`), contrassegna `e` per la cancellazione (oppure cancellalo subito se questo non va a danneggiare l'enumerazione)
                e_site_distance = point_segment_distance(site, e)
                e_c_site_distance = point_segment_distance(c.site, e)
                if e_site_distance < e_c_site_distance:
                    e.mark_to_be_deleted()

                # NOTE: Step 11
                # Se il segmento `e` interseca la retta `pb`, taglia e nel lato più lontano di `pb`, e memorizza il punto di intersezione in X
                e_pb_intersection = segment_intersection(
                    e,
                    from_line_to_segment(pb)
                )
                if e_pb_intersection:
                    X.append(e_pb_intersection)

            # NOTE: Step 12
            # In questo momento X dovrebbe contenere 0 o 2 punti; se ne ha 2, crea un nuovo Edge che li connetta, e aggiungi questo nuovo `new_edge` a `c`, `cell` e `E`
            if len(X) == 2:
                new_edge = Edge(X[0], X[1])
                c.edges.append(new_edge)
                cell.edges.append(new_edge)
                E.append(new_edge)
            elif len(X) == 0:
                pass
            else:
                debug(f"X should contain 0 or 2 elements, but it contains {len(X)} items. X: " + ", ".join([str(x) for x in X]))

            # NOTE: Step 13
            # Se necessario, cancella ogni segmento marcato nello step 10 sia da `c` che da `E`

            for cell in C:
                cell.edges = list(filter(lambda e: not e.to_be_deleted, cell.edges))

            # prev_E_len = len(E)
            # E = list(filter(lambda e: not e.to_be_deleted, E))
            # assert len(E) < prev_E_len, "No edges have been deleted from E"

    # Disegno gli assi cartesiani
    # pygame.draw.line(screen, reference_line_color, (0, screen_size[1]/2), (screen_size[0], screen_size[1]/2), 1)
    # pygame.draw.line(screen, reference_line_color, (screen_size[0]/2, 0), (screen_size[0]/2, screen_size[1]), 1)

    # Disegno il perimetro del rettangolo
    ref_line_color = (0, 0, 255)
    pygame.draw.line(screen, ref_line_color, (-width + screen_size[0]/2, -height + screen_size[1]/2), (width + screen_size[0]/2, -height + screen_size[1]/2))
    pygame.draw.line(screen, ref_line_color, (-width + screen_size[0]/2, height+screen_size[1]/2), (-width + screen_size[0]/2, -height + screen_size[1]/2))
    pygame.draw.line(screen, ref_line_color, (width + screen_size[0]/2, -height+screen_size[1]/2), (width + screen_size[0]/2, height + screen_size[1]/2))
    pygame.draw.line(screen, ref_line_color, (width + screen_size[0]/2, height+screen_size[1]/2), (-width + screen_size[0]/2, height + screen_size[1]/2))

    for edge in E:
        Draw.edge(edge)
    for cell in C:
        Draw.cell(cell)


screen_size = 1000, 800
pygame.init()
screen = pygame.display.set_mode(screen_size)
pygame.display.set_caption("Implementazione Voronoi - Gianluca Mondini")
screen.fill((255, 255, 255))

if __name__ == "__main__":
    import doctest
    doctest.testmod()

    compute_voronoi([Point(-20, -40), Point(0, 20), Point(100, 3), Point(-3, 3)], int(screen_size[0]/4-30), int(screen_size[1]/4-30))

    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.image.save(screen, "output.png")
                sys.exit()
