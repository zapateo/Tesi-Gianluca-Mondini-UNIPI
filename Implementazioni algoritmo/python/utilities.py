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

    def flip(self):
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
                self._cart_to_screen((shape.end.x, shape.end.y)),
                2
            )
            pygame.draw.circle(
                self.screen,
                line_color,
                self._cart_to_screen(
                    (shape.start.x, shape.start.y)
                ),
                2
            )
            # shape.start.x = round(shape.start.x, 1)
            # shape.start.y = round(shape.start.y, 1)
            # shape.end.x = round(shape.end.x, 1)
            # shape.end.y = round(shape.end.y, 1)
            # self._write_text(str((shape.start.x, shape.start.y)), (shape.start.x, shape.start.y))
            pygame.draw.circle(
                self.screen,
                line_color,
                self._cart_to_screen(
                    (shape.end.x, shape.end.y)
                ),
                2
            )
            # self._write_text(str((shape.end.x, shape.end.y)), (shape.end.x, shape.end.y))
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
