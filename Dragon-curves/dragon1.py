# Dragon curve with rounded corners; Python/tkinter implementation (hk  19 June 2024)
# After a BASIC program 'DRAAK1' from: Hans Lauwerier, Fractals, 1988
# See: https://mathworld.wolfram.com/DragonCurve.html

from graphics import GraphWin, Point, Line  # https://mcsp.wartburg.edu/zelle/python/
from math     import cos, sin

def main():
    pi = 3.1415926535
    p  = 9                                  # order of dragon; exponent for power of 2

    win = GraphWin(f"Dragon {p}", 1000, 700)
    win.setCoords(-0.7, -1.1, 1.7, 0.7)
    
    h  = 2.0**(-p/2.0);  s = 0
    x1 = h * cos(p*pi/4.0);   y1 = h * sin(p*pi/4.0)
    xt = 0.75*x1;             yt = 0.75*y1
    n  = 1.0;   end = 2.0**p - 1.0
    while n < end:
        m = n
        while m % 2 == 0:  m = m / 2.0
        d = 1 if m % 4 == 1 else -1
        s = (s + d) % 4
        x2 = x1 + h * cos((s - p/2.0) * pi/2.0)
        y2 = y1 + h * sin((s - p/2.0) * pi/2.0)
        xa = (3.0*x1 + x2) / 4.0;   ya = (3.0*y1 + y2) / 4.0
        xb = (x1 + 3.0*x2) / 4.0;   yb = (y1 + 3.0*y2) / 4.0;
        l = Line(Point(xt, yt), Point(xa, ya));  l.draw(win)
        l = Line(Point(xa, ya), Point(xb, yb));  l.draw(win)
        xt = xb;   yt = yb
        x1 = x2;   y1 = y2;
        n  = n + 1.0

main()
