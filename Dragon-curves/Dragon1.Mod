MODULE Dragon1;  (* hk  13 July 2024 *)       (* Dragon.Do 9 *)
(* Dragon curve with rounded corners
  - version with XYgraphics.LineToF( )
  - 'tail' of dragon (= start of curve) improved
  After a BASIC program 'DRAAK1' from: Hans Lauwerier, Fractals, 1988 *)

  IMPORT Math, In, Out, XY := XYplane, Gr := XYgraphics;
  
  CONST 
    pi = 3.1415926535;
    white = Gr.white;

  VAR
    p: INTEGER;  (* order of fractal, used as power of 2 *)
    h, x1, y1, x2, y2, xa, ya, xb, yb: REAL;

  PROCEDURE DrawSegment(s: INTEGER);
  BEGIN
    x2 := x1 + h * Math.cos((FLT(s) - FLT(p)/2.0) * pi/2.0);
    y2 := y1 + h * Math.sin((FLT(s) - FLT(p)/2.0) * pi/2.0);
    xa := (3.0*x1 + x2) / 4.0;   ya := (3.0*y1 + y2) / 4.0;
    xb := (x1 + 3.0*x2) / 4.0;   yb := (y1 + 3.0*y2) / 4.0;
    Gr.LineToF(xa, ya, white);
    Gr.LineToF(xb, yb, white);
    x1 := x2;  y1 := y2
  END DrawSegment;

  PROCEDURE Do* ;
    VAR m, n, d, s: INTEGER;
      end: REAL;
  BEGIN
    In.Open;  In.Int(p);  (* order of curve: any integer in {1..20}; numbers > 20 may take some time *)
    IF ~In.Done THEN p := 9 END;

    XY.OpenH(479);  (* 4:3 aspect ratio *)   XY.Clear;
    IF p = 0 THEN Gr.SetCoords(0.3, -0.5, 2.1, 1.3)
    ELSIF p < 4 THEN Gr.SetCoords(-0.7, -0.5, 1.7, 1.3)
    ELSIF p < 12 THEN Gr.SetCoords(-0.55, -1.0, 1.45, 0.45)
    ELSE Gr.SetCoords(-0.37, -0.68, 1.17, 0.34)
    END;

    h := Math.power(2.0, -FLT(p)/2.0);
    x1 := h * Math.cos(FLT(p)*pi/4.0);
    y1 := h * Math.sin(FLT(p)*pi/4.0);
    Gr.MoveToF(x1, y1);
    DrawSegment(4);  (* 'tail' (left end) *)
    n := 1;  end := Math.power(2.0, FLT(p)) - 1.0;  s := 0;
    WHILE n <= FLOOR(end) DO m := n;
      WHILE m MOD 2 = 0 DO m := m DIV 2 END;
      IF m MOD 4 = 1 THEN d := 1 ELSE d := -1 END;  (* direction: 1 = left,  -1 = right *)
      s := (s + d) MOD 4;
      DrawSegment(s);
      INC(n)
    END
  END Do;
 
END Dragon.Do 3

