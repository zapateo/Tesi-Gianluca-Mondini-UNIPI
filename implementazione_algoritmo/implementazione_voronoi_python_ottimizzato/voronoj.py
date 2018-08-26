import pygame
import sys

from geometria import *

ENABLED_DEBUG = True

def debug(msg):
    if ENABLED_DEBUG:
        print(f"[DEBUG] {msg}")

class Drawer:

    def __init__(self, screen, screen_width, screen_height):
        self.screen = screen
        self.screen_width = screen_width
        self.screen_height = screen_height
        self.clear()
        self.font = pygame.font.SysFont("freemono", 12)

    def title(self, t):
        pygame.display.set_caption(str(t))

    def _write_text(self, text, pos):
        """
        `pos` must be in cartesian form
        """
        surface = self.font.render(text, True, (0, 0, 0))
        self.screen.blit(surface, self._cart_to_screen(pos))
        pygame.display.flip()

    def clear(self):
        self.screen.fill((255, 255, 255))
        pygame.display.set_caption("Gianluca Mondini - Voronoj")

    def wait(self):
        while True:
            event = pygame.event.wait()
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()
            elif event.type == pygame.KEYDOWN:
                return

    def draw_all(self, shapes):
        for shape in shapes:
            self.draw(shape)

    def _cart_to_screen(self, pos):
        return (
            int(pos[0] + self.screen_width/2),
            int(self.screen_height - pos[1] - self.screen_height/2)
        )

    def draw(self, shape, annotation=None):
        if type(shape) == Point:
            pygame.draw.circle(
                self.screen,
                (255, 0, 0),
                self._cart_to_screen(
                    (shape.x, shape.y)
                ),
                5
            )
            if annotation:
                self._write_text(annotation, (shape.x, shape.y))
        elif type(shape) == Edge:
            line_color = (130, 130, 130,)
            pygame.draw.line(
                self.screen,
                line_color,
                self._cart_to_screen((shape.start.x, shape.start.y)),
                self._cart_to_screen((shape.end.x, shape.end.y))
            )
            pygame.draw.circle(
                self.screen,
                line_color,
                self._cart_to_screen(
                    (shape.start.x, shape.start.y)
                ),
                2
            )
            shape.start.x = round(shape.start.x, 1)
            shape.start.y = round(shape.start.y, 1)
            shape.end.x = round(shape.end.x, 1)
            shape.end.y = round(shape.end.y, 1)
            self._write_text(str((shape.start.x, shape.start.y)), (shape.start.x, shape.start.y))
            pygame.draw.circle(
                self.screen,
                line_color,
                self._cart_to_screen(
                    (shape.end.x, shape.end.y)
                ),
                2
            )
            self._write_text(str((shape.end.x, shape.end.y)), (shape.end.x, shape.end.y))
            if annotation:
                x = int((shape.start.x + shape.end.x)/2)
                y = int((shape.start.y + shape.end.y)/2)
                self._write_text(annotation, ((x, y)))
                pygame.draw.circle(
                    self.screen,
                    (255, 0, 0),
                    self._cart_to_screen((x, y)),
                    3
                )
        elif type(shape) == Line:
            pass
        else:
            raise Exception(f"Unknow shape {shape} of type {type(shape)}")
        pygame.display.flip()

def voronoj_cell(edges, primary_site, other_sites):
    """
    In un diagramma di Voronoj delimitato da `edges` e con un insieme di siti
    composto da `primary_site` e `other_sites`, restituisce una lista di oggetti
    `Edge` che delimitano la cella di Voronoj corrispondente a `primary_site`

    Esempi/Test
    ===========

    >>> from geometria import *

    Caso in cui l'area sia quadrata

    # >>> edges = [E(0, 0, 100, 0), E(100, 0, 100, 100), E(100, 100, 0, 100), E(0, 100, 0, 0)]
    # >>> primary_site = Point(25, 25)
    # >>> other_sites = [Point(75, 75)]
    # >>> cell = voronoj_cell(edges, primary_site, other_sites)
    # >>> for edge in cell:
    # ...     print(edge)
    # Edge_from:Point(100.0, 0.0)to:Point(0, 0)
    # Edge_from:Point(0.0, 100.0)to:Point(0, 0)
    # Edge_from:Point(100.0, 0.0)to:Point(0.0, 100.0)
    #
    # >>> edges = [E(100, 0, 300, 0), E(300, 0, 300, 200), E(300, 200, 200, 400), E(200, 400, 0, 200), E(0, 200, 100, 0)]
    # >>> primary_site = Point(200, 300)
    # >>> other_sites = [Point(100, 100), Point(100, 200)]
    # >>> cell = voronoj_cell(edges, primary_site, other_sites)
    # >>> for edge in cell:
    # ...     print(edge)
    # Edge_from:Point(300, 200)to:Point(200, 400)
    # Edge_from:Point(300.0, 125.0)to:Point(300, 200)
    # Edge_from:Point(100.0, 300.0)to:Point(200, 400)
    # Edge_from:Point(250.0, 150.0)to:Point(300.0, 125.0)
    # Edge_from:Point(100.0, 300.0)to:Point(250.0, 150.0)
    """
    #---------------------------------------------------------------------------
    for site in other_sites:
        #-----------------------------------------------------------------------
        union_edge = Edge(primary_site, site)
        #-----------------------------------------------------------------------
        perp_bisect = perpendicular_bisector(union_edge)
        #-----------------------------------------------------------------------
        intersections = []
        #-----------------------------------------------------------------------
        new_edges = []
        #-----------------------------------------------------------------------
        # debug("### for edge in edges:")
        for edge in edges:
            if edge.to_be_deleted:
                # debug(f"ignoring {edge} cause it's going to be deleted")
                continue
            # debug(f"searching intersections with {edge}, edge.to_be_deleted: {edge.to_be_deleted}..")
            intersect = segment_intersection(
                from_line_to_segment(perp_bisect),
                edge
            )
            #-------------------------------------------------------------------
            if intersect:
                # debug(f"found intersection at {intersect} with {edge}")
                #---------------------------------------------------------------
                edge.to_be_deleted = True
                #---------------------------------------------------------------
                p1 = edge.start
                p2 = edge.end
                edge_p1_primary_site = Edge(p1, primary_site)
                edge_p2_primary_site = Edge(p2, primary_site)
                int1 = segment_intersection(
                    from_line_to_segment(perp_bisect),
                    edge_p1_primary_site
                )
                int2 = segment_intersection(
                    from_line_to_segment(perp_bisect),
                    edge_p2_primary_site
                )
                if int1 and not int2:
                    keep = p2
                elif not int1 and int2:
                    keep = p1
                elif int1 and int2:
                    # FIXME
                    # raise Exception("int1 and int2")
                    pass
                else:
                    raise Exception()
                #---------------------------------------------------------------

                new_edge = Edge(intersect, keep)
                new_edges.append(new_edge)
                #---------------------------------------------------------------
                add_to_intersections = True
                close_value = lambda a, b: abs(a - b) < 0.001
                for i in intersections:
                    if close_value(i.x, intersect.x) and close_value(i.y, intersect.y):
                        add_to_intersections = False
                if add_to_intersections:
                    intersections.append(intersect)
                #---------------------------------------------------------------
            # end if intersect
            #-----------------------------------------------------------------------
            # FIXME quando un bordo è stato contrassegnato interrompi l'iterazione
            for outer_edge in edges:
                # debug(f"checking if {outer_edge} needs to be deleted")
                for point in (outer_edge.start, outer_edge.end):
                    for inner_edge in edges:
                        join_edge = Edge(primary_site, point)
                        intersection = segment_intersection(inner_edge, join_edge)
                        if intersection and not points_are_close(intersection, point):
                            outer_edge.to_be_deleted = True
            #---------------------------------------------------------------------------
        # end for edge in edges
        edges = edges + new_edges
        #-----------------------------------------------------------------------
        if len(intersections) == 2:
            edges.append(
                Edge(intersections[0], intersections[1])
            )
        elif len(intersections) == 0:
            raise Exception("no intersections..")
        else:
            drawer.clear()
            drawer.draw(from_line_to_segment(perp_bisect), "pb")
            drawer.draw_all(other_sites)
            drawer.draw(primary_site, "prim. site")
            drawer.draw_all(intersections)
            drawer.draw_all(edges)
            drawer.title("EXCEPTION!!!")
            drawer.wait()
            raise Exception(f"intersections contains {len(intersections)} elements, but it should contain 0 or 2")
        #-----------------------------------------------------------------------
        edges = list(filter(lambda e: not e.to_be_deleted, edges))
        #-----------------------------------------------------------------------
    # end for site in other_sites

    edges = list(filter(lambda e: not e.to_be_deleted, edges))
    #---------------------------------------------------------------------------
    temp_edges = []
    for edge in edges:
        insert = True
        for temp_edge in temp_edges:
            if edges_are_close(edge, temp_edge):
                insert = False
        if insert:
            temp_edges.append(edge)
    edges = temp_edges
    #---------------------------------------------------------------------------
    return edges

def center_of_mass(edges):
    """
    Restituisce le coordinate del centro di massa del poligono `edges`

    Il poligono deve essere convesso e i segmenti contenuti in `edges` devono
    delimitare un perimetro chiuso

    >>> str(center_of_mass([E(0, 0, 1, 0), E(1, 0, 1, 1), E(1, 1, 0, 1), E(0, 1, 0, 0)]))
    'Point(0.5, 0.5)'
    """
    x_sum = 0
    y_sum = 0
    for e in edges:
        # Aggiungo solo il punto e.start perchè
        # il punto e.end è aggiunto automaticamente dal segmente
        # successivo
        x_sum += e.start.x
        y_sum += e.start.y
    n = len(edges)
    return Point(x_sum/n, y_sum/n)


if __name__ == "__main__":

    screen_width, screen_height = 1300, 900
    pygame.init()
    screen = pygame.display.set_mode((screen_width, screen_height))
    global drawer
    drawer = Drawer(screen, screen_width, screen_height)

    import doctest
    doctest.testmod()

    # sites = [Point(200, 300), Point(100, 100), Point(100, 200)]
    # for i in range(10):
    #     edges_to_draw = []
    #     for primary_site in sites:
    #         edges = [E(100, 0, 300, 0), E(300, 0, 300, 200), E(300, 200, 200, 400), E(200, 400, 0, 200), E(0, 200, 100, 0)]
    #         other_sites = sites[:]
    #         other_sites.remove(primary_site)
    #         cell = voronoj_cell(edges, primary_site, other_sites)
    #         edges_to_draw += cell
    #         com = center_of_mass(cell)
    #         primary_site.next_x = com.x
    #         primary_site.next_y = com.y
    #     drawer.clear()
    #     drawer.draw_all(edges_to_draw)
    #     drawer.draw_all(sites)
    #     drawer.wait()
    #     for site in sites:
    #         site.x = site.next_x
    #         site.y = site.next_y
        # drawer.clear()
        # drawer.draw_all(edges_to_draw)
        # drawer.draw_all(sites)
        # drawer.wait()
    sites = [Point(200, 300), Point(100, 100), Point(100, 200)]
    primary_site = sites[0]
    other_sites = sites[:]
    other_sites.remove(primary_site)
    for i in range(10):
        edges = [E(100, 0, 300, 0), E(300, 0, 300, 200), E(300, 200, 200, 400), E(200, 400, 0, 200), E(0, 200, 100, 0)]
        cell = voronoj_cell(edges, primary_site, other_sites)
        com = center_of_mass(cell)
        drawer.clear()
        drawer.draw(primary_site, "ps")
        drawer.draw_all(cell + other_sites)
        drawer.wait()
        primary_site.x = com.x
        primary_site.y = com.y



    # edges = [
    #     Edge(Point(-300, 0), Point(250, -40)),
    #     Edge(Point(250, -40), Point(250, 250)),
    #     Edge(Point(250, 250), Point(0, 250)),
    #     Edge(Point(0, 250), Point(-300, 0)),
    # ]
    # primary_site = Point(100, 70)
    # other_sites = [
    #     Point(-43, 30),
    #     Point(200, 60)
    # ]
    # voronoj_cell(edges, primary_site, other_sites)
