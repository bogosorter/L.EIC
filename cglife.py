'''
An implementation of Conway's game of life by M7kra
https://m7kra.github.io

Instructions:

- Press space to play/pause the game
- When paused, left click will enable cells and right click will delete them
- Press r to restart the game
- Run with '--random' to start with a random configuration

Enjoy!
'''


import random
import pygame
from pygame.locals import QUIT
import sys

BACKGROUND = (60, 60, 60)
COLOR1 = (40, 108, 147)
COLOR2 = (153, 91, 192)

WIDTH = 200
HEIGHT = 100
CELL_SIZE = 6

TIME_INTERVAL = 100


class CGLife:

    def __init__(self, state = 'empty'):

        if state == 'empty': self.empty()
        else: self.random()

    def empty(self):
        self.cells = []
        for _ in range(HEIGHT):
            row = [False for _ in range(WIDTH)]
            self.cells.append(row)

    def random(self):
        self.cells = []
        for _ in range(HEIGHT):
            row = [random.choice([True, False]) for _ in range(WIDTH)]
            self.cells.append(row)

    def update(self):
        cells = []
        for i in range(HEIGHT):
            row = [self.next_value(j, i) for j in range(WIDTH)]
            cells.append(row)
        self.cells = cells

    def next_value(self, x, y):
        neighbors = 0
        for i in range(x - 1, x + 2):
            for j in range(y - 1, y + 2):
                if i == x and j == y: continue
                neighbors += self.alive(i, j)

        if not self.alive(x, y):
            if neighbors == 3: return True
            return False 
        return 2 <= neighbors <= 3
    
    def alive(self, x, y):
        if x < 0 or x >= WIDTH: return False
        if y < 0 or y >= HEIGHT: return False
        return self.cells[y][x]
    
    def click(self, event):
        x, y = pygame.mouse.get_pos()

        x = x // CELL_SIZE - 1
        y = y // CELL_SIZE - 1

        if (not 0 <= x < WIDTH) or (not 0 <= y <= HEIGHT): return

        self.cells[y][x] = event.button == 1

class GameManager:

    def __init__(self):
        pygame.init()
        self.surface = pygame.display.set_mode((CELL_SIZE * (WIDTH + 2), CELL_SIZE * (HEIGHT + 2)))

        self.random = len(sys.argv) > 1 and sys.argv[1] == '--random'
        self.cglife = CGLife('random' if self.random else 'empty')
        self.playing = False
        self.draw()
        self.loop()
    
    def loop(self):
        mouse_event = None

        while True:
            for event in pygame.event.get():
                if event.type == QUIT:
                    pygame.quit()
                    quit()
                if event.type == pygame.KEYDOWN and event.key == pygame.K_SPACE:
                    self.playing = not self.playing
                if event.type == pygame.KEYDOWN and event.key == pygame.K_r:
                    self.restart()
                elif event.type == pygame.MOUSEBUTTONDOWN:
                    mouse_event = event
                elif event.type == pygame.MOUSEBUTTONUP: mouse_event = None
            
            if self.playing:
                self.cglife.update()
                pygame.time.wait(TIME_INTERVAL)
            elif mouse_event: self.cglife.click(mouse_event)

            self.draw()

    def draw(self):
        self.surface.fill(BACKGROUND)

        for i in range(HEIGHT):
            for j in range(WIDTH):
                if not self.cglife.alive(j, i): continue
                x = (1 + j) * CELL_SIZE
                y = (1 + i) * CELL_SIZE
                color = COLOR1 if self.playing else COLOR2
                pygame.draw.rect(self.surface, color, pygame.Rect(x, y, CELL_SIZE, CELL_SIZE))

        pygame.display.flip()

    def restart(self):
        if self.random: self.cglife.random()
        else: self.cglife.empty()
        self.playing = False


GameManager()
