MODULE ArchiSpiral0;  (* hk  15 June 2024 *)
(* Archimedean spiral (a.k.a. arithmetic spiral).
   First attempt, without XYplane.OpenH( ) and XYgraphics.LineToF( ).
   After a BASIC program 'ARCHI' from: Hans Lauwerier, Fractals, 1988 *)

  IMPORT Math, In, XY := XYplane, Gr := XYgraphics;

  CONST 
    pi = 3.1415926535;
    a = 0.1;
    white = Gr.white;
 
  PROCEDURE Do* ;
    VAR r, t, x0, y0, x1, y1: REAL;
  BEGIN
    XY.Open;  XY.Clear;
    Gr.SetCoords(-12.0, -9.0, 12.0, 9.0);
    x0 := 0.0;  y0 := 0.0;
    t := 0.0;
    WHILE t <= 16.0*pi DO
      r := a * t;
      x1 := r * Math.cos(t);
      y1 := r * Math.sin(t);
      Gr.LineF(x0, y0, x1, y1, white);
      x0 := x1;  y0 := y1;
      t := t + 0.1
    END
  END Do;

END ArchiSpiral0.Do
