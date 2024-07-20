MODULE XYgraphics;  (* IN V5 *)  (* hk 12 May 2024, 13 July 2024 *)
(* Some graphics primitives for XYplane drawing, with automatic coordinate transformation *)

  IMPORT D := Display, Out, XY := XYplane;

  CONST
    white* = D.white;
    paint* = D.paint;

  TYPE 
    LineRec = RECORD
      decision, incr1, incr2, 
      alwaysIncr, S, A: INTEGER;
      upS, upA: BOOLEAN;
    END;

  VAR
    xLL, yLL,              (* lower left World coordinates *)
    xUR, yUR: REAL;        (* upper right World coordinates *)
    scaleX, scaleY: REAL;  (* scale factors for coordinate transformations *)
    xt, yt: REAL;          (* temporary variables for LineTo *)

(* ----- Coordinate transformation ----- *)   

  PROCEDURE SetCoords* (xLowerL, yLowerL, xUpperR, yUpperR: REAL);
  (* Set the World coordinates of the XYplane window *)
  BEGIN
    xLL := xLowerL;    yLL := yLowerL;
    xUR := xUpperR;  yUR := yUpperR;
    scaleX := FLT(XY.W) / (xUR - xLL);
    scaleY := FLT(XY.H) / (yUR - yLL);
  END SetCoords;
  
  PROCEDURE ToXY(VAR x, y: REAL);
  (* Transform World coordinates to XYplane pixels *)
  BEGIN
    x := (x - xLL) * scaleX;
    y := (y - yLL) * scaleY;
  END ToXY;

(* ----- Point -------- *)
 
  PROCEDURE Point* (x, y: REAL);
  BEGIN
    ToXY(x, y);  D.Dot(white, FLOOR(x), FLOOR(y) , paint)
  END Point;

(* ----- Circle -------- *)

  PROCEDURE CircleBres (xc, yc, r: INTEGER);
  (* Bresenham's algorithm for drawing a circle *)
    VAR x, y, d: INTEGER;

    PROCEDURE DrawCircle0 (xc, yc, x, y: INTEGER);
    BEGIN
      D.Dot(white, xc+x, yc+y, paint);
      D.Dot(white, xc-x, yc+y, paint);
      D.Dot(white, xc+x, yc-y, paint);
      D.Dot(white, xc-x, yc-y, paint);
      D.Dot(white, xc+y, yc+x, paint);
      D.Dot(white, xc-y, yc+x, paint); 
      D.Dot(white, xc+y, yc-x, paint);
      D.Dot(white, xc-y, yc-x, paint)
    END DrawCircle0;

    PROCEDURE DrawCircle1 (xc, yc, x, y: INTEGER);
    BEGIN
      Point(FLT(xc+x), FLT(yc+y));
      Point(FLT(xc-x), FLT(yc+y));
      Point(FLT(xc+x), FLT(yc-y));
      Point(FLT(xc-x), FLT(yc-y));
      Point(FLT(xc+y), FLT(yc+x));
      Point(FLT(xc-y), FLT(yc+x)); 
      Point(FLT(xc+y), FLT(yc-x));
      Point(FLT(xc-y), FLT(yc-x))
    END DrawCircle1;

  BEGIN
    x := 0;  y := r;
    d := 3 - 2 * r;
    DrawCircle0(xc, yc, x, y);
    WHILE y >= x DO
      (* for each pixel we will draw all eight pixels *)
      INC(x);
      (* check for decision parameter and correspondingly update d, x, y *)
      IF d > 0 THEN
        DEC(y);
        d := d + 4 * (x - y) + 10
      ELSE
        d := d + 4 * x + 6
      END;
      DrawCircle0(xc, yc, x, y)
    END
  END CircleBres;

  PROCEDURE Circle* (xc, yc, r: REAL);
  BEGIN
    ToXY(xc, yc);  r := r * scaleY;
    CircleBres (FLOOR(xc), FLOOR(yc), FLOOR(r))
  END Circle;

(* ----- Line -------- *)
  
  PROCEDURE Hline* (x, y, l: REAL; mode: INTEGER);
  (* Draw a horizontal line starting at point x, y with length l *)
  BEGIN
    ToXY(x, y);  l := l * scaleX;
    IF x < FLT(XY.X) THEN x := FLT(XY.X) END;
    IF y < FLT(XY.Y) THEN y := FLT(XY.Y) END;
    IF x + l > FLT(XY.W) THEN l := FLT(XY.W) - x END;
    D.ReplConst(D.white, FLOOR(x), FLOOR(y), FLOOR(l), 1, mode);
  END Hline;

  PROCEDURE Vline* (x, y, l: REAL; mode: INTEGER);
  (* Draw a vertical line starting at point x, y with lenght l *)
  BEGIN
    ToXY(x, y);  l := l * scaleY;
    IF x < FLT(XY.X) THEN x := FLT(XY.X) END;
    IF y < FLT(XY.Y) THEN y := FLT(XY.Y) END;
    IF y + l > FLT(XY.H) THEN l := FLT(XY.H) - y END;
    D.ReplConst(white, FLOOR(x), FLOOR(y), 1, FLOOR(l), mode);
  END Vline;


(* -- Line0 -- *)
  
  PROCEDURE Line0* (a, b: INTEGER);
  (* Bresenham's line algorithm for the first octant. From R&W, Programming in Oberon, p. 104 *)
    VAR x, y, h: INTEGER;
  BEGIN
    y := 0;
    FOR x := 0 TO a DO
      h := b*x - a*y + b - a DIV 2;
      IF h > 0 THEN INC(y) END;
      D.Dot(white, x, y, paint)
    END
  END Line0;


(* -- Line1 -- *)

  PROCEDURE SetLineRec (a1, s1, a2, s2: INTEGER;  VAR L: LineRec);
  (* This procedure initializes the LineRec L. The a parameters are
    the x/y coordinates which always change, the s parameters are
    the y/x coordinates which change only sometimes.
  *)
    VAR da, ds: INTEGER;
  BEGIN
    da := ABS(a2 - a1);  (* difference of 'always' variable *)
    ds := ABS(s2 - s1);  (* difference of 'sometimes' variable *)
    L.alwaysIncr := ds DIV da;
    L.incr1 := 2 * (ds MOD da);
    L.decision := L.incr1 - da;
    L.incr2 := L.decision - da;
    L.A := a1;  L.S := s1;
    L.upA := a1 <= a2;  (* indicate if A should be changed each time *)
    L.upS := s1 <= s2
  END SetLineRec;

  PROCEDURE NextLine (VAR L: LineRec);
  (* Calculates next 'X, Y' position of line defined by L *)
  BEGIN
    IF L.decision < 0 THEN
      INC(L.decision, L.incr1);
      IF L.upS THEN INC(L.S, L.alwaysIncr) ELSE DEC(L.S, L.alwaysIncr) END
    ELSE
      INC(L.decision, L.incr2);
      IF L.upS THEN INC(L.S, L.alwaysIncr + 1) ELSE DEC(L.S, L.alwaysIncr + 1) END
    END;
    IF L.upA THEN INC(L.A) ELSE DEC(L.A) END
  END NextLine;

  PROCEDURE Line1* (x1, y1, x2, y2, colour: INTEGER);
  (* Bresenham's line algorithm for all octants. From Mitchell, Modula-2 Applied, p. 34 *)
    
    PROCEDURE ActualLine (a1, s1, a2, s2: INTEGER; swap: BOOLEAN);
    (*  - a1, a2 are the end coordinates of variable a ('always changed').
       - s1, s2 are for the variable s ('sometimes changed').
       - swap indicates whether a is X and s is Y, or not.
    *)
      VAR L: LineRec;
    BEGIN
      SetLineRec(a1, s1, a2, s2, L);
      IF swap THEN D.Dot(white, L.S, L.A, paint) ELSE D.Dot(white, L.A, L.S, paint) END;  
      WHILE L.A # a2 DO
        NextLine(L);
        IF swap THEN D.Dot(white, L.S, L.A, paint) ELSE D.Dot(white, L.A, L.S, paint) END;  
      END
    END ActualLine;

  BEGIN  (* first test to see whether x or y always changed *)
    IF ABS(x1 - x2) >= ABS(y1 - y2) THEN
      ActualLine(x1, y1, x2, y2, FALSE)
    ELSE
      ActualLine(y1, x1, y2, x2, TRUE)    
    END
  END Line1;


(* -- Line2 -- *)

  PROCEDURE Line2* (x0, y0, x1, y1, color: INTEGER);
  (* Bresenham's line algorithm for all octants. Draws a jagged straight line from points (x0, y0) to (x1, y1).
    After: https://medium.com/@trey.tomes/bresenhams-line-algorithm-2dc69ee7dc15
    Also see: Foley, Van Dam & al., Computer Graphics, 2nd ed., p. 74-78.
  *)
    VAR dx, dy, sx, sy, err, e2: INTEGER;
      exit: BOOLEAN;
  BEGIN
    dx := ABS(x1 - x0);
    IF x0 < x1 THEN sx := 1 ELSE sx := -1 END;
    dy := -ABS(y1 - y0);
    IF y0 < y1 THEN sy := 1 ELSE sy := -1 END;
    err := dx + dy;

    exit := FALSE;
    REPEAT
      D.Dot(white, x0, y0, paint);
      IF (x0 = x1) & (y0 = y1) THEN exit := TRUE
      ELSE
        e2 := LSL(err, 1);  (* e2 := err DIV 2 *)
        IF e2 >= dy THEN
          IF x0 = x1 THEN exit := TRUE
          ELSE
            INC(err, dy);
            INC(x0, sx);
          END
        END;
        IF (e2 <= dx) & ~exit THEN
          IF y0 = y1 THEN exit := TRUE
          ELSE
            INC(err, dx);
            INC(y0, sy)
          END
        END 
      END
    UNTIL exit
  END Line2;

  PROCEDURE ClipXF (VAR x: REAL);
  BEGIN
    IF x < FLT(XY.X) THEN x := FLT(XY.X) END;
    IF x > FLT(XY.W) THEN x := FLT(XY.W) END
  END ClipXF;

  PROCEDURE ClipYF (VAR y: REAL);
  BEGIN
    IF y < FLT(XY.Y) THEN y := FLT(XY.Y) END;
    IF y > FLT(XY.H) THEN y := FLT(XY.H) END
  END ClipYF;
  
  PROCEDURE ClipX (VAR x: INTEGER);
  BEGIN
    IF x < XY.X THEN x := XY.X END;
    IF x > XY.W THEN x := XY.W END
  END ClipX;

  PROCEDURE ClipY (VAR y: INTEGER);
  BEGIN
    IF y < XY.Y THEN y := XY.Y END;
    IF y > XY.H THEN y := XY.H END
  END ClipY;


  PROCEDURE LineF* (x0, y0, x1, y1: REAL; mode: INTEGER);
  BEGIN
    ToXY(x0, y0);  ToXY(x1, y1);
    xt := x1;  yt := y1;

    IF x0 < FLT(XY.X) THEN x0 := FLT(XY.X) END;
    IF x0 > FLT(XY.W) THEN x0 := FLT(XY.W) END;

    IF x1 < FLT(XY.X) THEN x1 := FLT(XY.X) END;
    IF x1 > FLT(XY.W) THEN x1 := FLT(XY.W) END;

    IF y0 < FLT(XY.Y) THEN y0 := FLT(XY.Y) END;
    IF y0 > FLT(XY.H) THEN y0 := FLT(XY.H) END;

    IF y1 < FLT(XY.Y) THEN y1 := FLT(XY.Y) END;
    IF y1 > FLT(XY.H) THEN y1 := FLT(XY.H) END;

    Line2(FLOOR(x0), FLOOR(y0), FLOOR(x1), FLOOR(y1), white)
  END LineF;


(* ----- MoveToF and LineToF -------- *)

  PROCEDURE MoveToF* (x, y: REAL);
  (* Sets the screen position to (x, y) *)
  BEGIN
    ToXY(x, y);
    xt := x;  yt := y
  END MoveToF;


  PROCEDURE LineToF* (x, y: REAL; mode: INTEGER);
  (* Draws a line from the previous screen position to (x, y). 
    The starting position should be set by GoToF or LineF. *)
  BEGIN
    ToXY(x, y);
    IF x < FLT(XY.X) THEN x := FLT(XY.X) END;
    IF x > FLT(XY.W) THEN x := FLT(XY.W) END;
    IF y < FLT(XY.Y) THEN y := FLT(XY.Y) END;
    IF y > FLT(XY.H) THEN y := FLT(XY.H) END;
    Line2(FLOOR(xt), FLOOR(yt), FLOOR(x), FLOOR(y), white);
    xt := x;  yt := y
  END LineToF;


(* ----- Rect -------- *)

  PROCEDURE Rect* (x0, y0, x1, y1: INTEGER; color: INTEGER; fill: BOOLEAN);
  (* Draws a rectangle; (x0, y0) is lower left corner, (x1, y1) is upper right corner *)
  BEGIN
    ClipX(x0);  ClipY(y0);  ClipX(x1);  ClipY(y1);
    IF fill THEN
      D.ReplConst(color, x0, y0, x1-x0, y1-y0, color);
    ELSE
      IF y1 > XY.Y-1 THEN D.ReplConst(color, x0, y0, x1-x0, 1, color) END;  (* lower hor. *)
      IF y1 < XY.H-1 THEN D.ReplConst(color, x0, y1, y1-y0, 1, color) END;  (* upper hor. *)
      IF x1 > XY.X-1 THEN D.ReplConst(color, x0, y0, 1, y1-y0, color) END;  (* left vert. *)
      IF x1 < XY.W-1 THEN D.ReplConst(color, x1, y0, 1, y1-y0, color) END;  (* right vert. *)
    END
  END Rect;

  PROCEDURE RectF* (x0, y0, x1, y1: REAL; color: INTEGER; fill: BOOLEAN);
  (* Draws a rectangle; (x0, y0) is lower left corner, (x1, y1) is upper right corner *)
  BEGIN
    ToXY(x0, y0);  ToXY(x1, y1);
    ClipXF(x0);  ClipYF(y0);  ClipXF(x1);  ClipYF(y1);
    IF fill THEN
      D.ReplConst(color, FLOOR(x0), FLOOR(y0), FLOOR(x1-x0), FLOOR(y1-y0), color);
    ELSE
      D.ReplConst(color, FLOOR(x0), FLOOR(y0), FLOOR(x1-x0), 1, color);  (* lower hor. *)
      D.ReplConst(color, FLOOR(x0), FLOOR(y1), FLOOR(y1-y0), 1, color);  (* upper hor. *)
      D.ReplConst(color, FLOOR(x0), FLOOR(y0), 1, FLOOR(y1-y0), color);  (* left vert. *)
      D.ReplConst(color, FLOOR(x1), FLOOR(y0), 1, FLOOR(y1-y0), color);  (* right vert. *)
    END
  END RectF;

END XYgraphics.
