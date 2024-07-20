MODULE Dragon90;  (* hk  15 July 2024 *)   (* Dragon90.Do 8 *)
(* Dragon curves with right (90 degrees) angles.
  After a BASIC program 'DRAAK' from: Hans Lauwerier, Fractals, 1988.
  The command Dragon90.Do accepts an integer parameter 0..15 for the order of the curve.
  The order of the curve is the number of times the paper slip is folded. *)
 
  IMPORT Math, In, Out, XY := XYplane, Gr := XYgraphics;
  
  PROCEDURE Do* ;
    CONST 
      pi = 3.1415926535;
      white = Gr.white;
    VAR
      p: INTEGER;  (* order of dragon curve; used as power of 2 *)      
      m, n, d, s: INTEGER;
      a, b, h, x, y, end: REAL;
  BEGIN 
    a := pi/2.0;  (* pi/2.0 radians = 90 degrees *)
    In.Open;  In.Int(p);  (* any integer in {0..15} *)
    IF ~In.Done THEN p := 8 END;
    IF p <= 9 THEN
      XY.OpenH(478);  Gr.SetCoords(-1.1, -1.4, 2.1, 1.0)  (* aspect ratio 4:3 *)  
    ELSIF (10 <=p) & (p <= 12) THEN
      XY.OpenH(638);  Gr.SetCoords(-1.2, -0.4, 0.8, 1.6)  (* aspect ratio 1:1 *)
    ELSIF (13 <= p) & (p <= 15) THEN
      XY.OpenH(638);  Gr.SetCoords(-1.0, -1.4, 1.0, 0.6)  (* aspect ratio 1:1 *)
    ELSE
      Out.String("Parameter error: p must be in { 0...15 }."); Out.Ln
    END;
    IF (0 <= p) & (p <= 15) THEN
      XY.Clear;
      h := Math.power(2.0, -FLT(p)/2.0);
      b := pi - a;  x := h;  y := 0.0;  s := 0;
      Gr.LineF(0.0, 0.0, x, y, white);
      n := 1;  end := Math.power(2.0, FLT(p)) - 1.0;
      WHILE n <= FLOOR(end) DO m := n; 
        WHILE m MOD 2 = 0 DO m := m DIV 2 END;
        IF m MOD 4 = 1 THEN d := 1 ELSE d := -1 END;
        s := s + d;
        x := x + h * Math.cos(FLT(s)*b);
        y := y + h * Math.sin(FLT(s)*b);
        Gr.LineToF(x, y, white);
        INC(n)
      END
    END
  END Do;

END Dragon90.Do 11    System.Free Dragon90 ~
