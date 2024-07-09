MODULE Dragon1; (* hk  16 June 2024 *)               (* Dragon1.Do 10   ORP.Compile *   System.Free Dragon1 ~ *)
(* Dragon curve with rounded corners.
  After a BASIC program 'DRAAK1' from: Hans Lauwerier, Fractals, 1988 *)

  IMPORT Math, In, XY := XYplane, Gr := XYgraphics;
  
  CONST 
    pi = 3.1415926535;
    white = Gr.white;

  VAR
    pInt: INTEGER; 
    p: REAL;  (* order of curve (exponent for power of 2) *)

  PROCEDURE REM (D, d: INTEGER): INTEGER;
  (* Remainder of Euclidean division 
     (as opposed to remainder of FLOORed division, which is given by Oberon's MOD) *)
  RETURN (ORD(D > 0) - ORD(D < 0)) * (ABS(D) MOD ABS(d))
  END REM;

  PROCEDURE Do* ;
    VAR m, n, d, s: INTEGER;
      h, end, x1, y1, x2, y2, xa, ya, xb, yb, xt, yt: REAL;
  BEGIN
    In.Open;  In.Int(pInt);  (* order of curve: any integer in {1..19}; numbers > 19 take some time *)
    IF ~In.Done THEN p := 9.0 ELSE p := FLT(pInt) END; 
    XY.OpenH(478);  (* 4:3 aspect ratio *)
    XY.Clear;
    Gr.SetCoords(-0.7, -1.1, 1.7, 0.7);
    h := Math.power(2.0, -p/2.0);  s := 0;
    x1 := h * Math.cos(p*pi/4.0);
    y1 := h * Math.sin(p*pi/4.0);
    xt := 0.75*x1;  yt := 0.75*y1;
    n := 1;  end := Math.power(2.0, p) - 1.0;
    WHILE n <= FLOOR(end) DO m := n;
      WHILE m MOD 2 = 0 DO m := m DIV 2 END;
      IF m MOD 4 = 1 THEN d := 1 ELSE d := -1 END;  (* direction: 1 = left,  -1 = right *)
   (* s := (s + d) MOD 4; *)
      s := REM(s + d, 4);
      x2 := x1 + h * Math.cos((FLT(s) - p/2.0) * pi/2.0);
      y2 := y1 + h * Math.sin((FLT(s) - p/2.0) * pi/2.0);
      xa := (3.0*x1 + x2) / 4.0;  ya := (3.0*y1 + y2) / 4.0;
      xb := (x1 + 3.0*x2) / 4.0;  yb := (y1 + 3.0*y2) / 4.0;
      Gr.LineF(xt, yt, xa, ya, white);
      Gr.LineF(xa, ya, xb, yb, white);
      xt := xb;  yt := yb;
      x1 := x2;  y1 := y2;
      INC(n)
    END
  END Do;

END Dragon1.
