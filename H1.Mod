MODULE H1;  (* hk  17 May 2024 *)
(* Fractal on letter H. After a BASIC program 'BoomH1' from: Hans Lauwerier, Fractals, 1988.
  An optional integer parameter for command H1.Do sets the order of the H-fractal (1 < order < 12; default is 10) *)

  IMPORT In, Math, XY := XYplane, Gr := XYgraphics;

  CONST 
    maxOrder = 11;
    white = Gr.white;

  VAR
    order: INTEGER;
    c,                   (* contraction ratio: sqrt(1/2) *)
    cM: REAL;            (* c^m, so c^2 = 1/2, etc. *)
 
  PROCEDURE Do* ;

    VAR order, s, m, n, beg, end: INTEGER;
      x: ARRAY 4096 OF REAL;          (* for order < 12 *)
      y: ARRAY 4096 OF REAL;

    PROCEDURE IntPower(n, e: INTEGER): INTEGER;  (* simplistic n^e *)
      VAR p: INTEGER;
    BEGIN p := 1;
      WHILE e > 0 DO p := p * n; DEC(e) END
    RETURN p
    END IntPower;

  BEGIN
    In.Open;  In.Int(order);
    IF (order < 2) OR (order > maxOrder) OR ~In.Done THEN order := 10 END;
    XY.Open;  XY.Clear;
    Gr.SetCoords(-2.0, -1.5, 2.0, 1.5);
    c := Math.sqrt(0.5);
    x[1] := 0.0;  y[1] := 0.0;
    FOR m := 0 TO order - 1 DO
      s := m MOD 2;
      beg := IntPower(2, m);
      end := IntPower(2, m+1) - 1;
      FOR n := beg TO end DO
        IF s = 1 THEN
          cM := Math.power(c, FLT(m));
          x[2*n]     := x[n];   y[2*n]     := y[n] + cM;
          x[2*n + 1] := x[n];   y[2*n + 1] := y[n] - cM
        ELSE
          cM := Math.power(c, FLT(m));
          x[2*n]     := x[n] + cM;   y[2*n]     := y[n];
          x[2*n + 1] := x[n] - cM;   y[2*n + 1] := y[n]
        END
      END
    END;
    end := IntPower(2, order) - 1;
    FOR n := 1 TO end DO
      Gr.LineF(x[2*n], y[2*n], x[2*n + 1], y[2*n + 1], white)
    END
  END Do;

END H1.Do

