MODULE LogSpiral; (* hk  22 July 2024 *)
(* Logarithmic spiral (a.k.a. growth spiral). Version with Gr.LineToF( ).
   After a BASIC program 'LOGSPIRA' from: Hans Lauwerier, Fractals, 1988 *)

  IMPORT Math, In, XY := XYplane, Gr := XYgraphics;

  CONST 
    pi = 3.1415926535;
    white = Gr.white;
 
  PROCEDURE Do* ;
    CONST 
      a = 0.1;  (* x-coordinate of starting point *) 
      b = 0.1;  (* growth rate *)
    VAR 
      r, t, x, y: REAL;
  BEGIN
    XY.OpenH(XY.square);  XY.Clear;
    Gr.SetCoords(-4.0, -3.0, 4.0, 3.0);
    Gr.MoveToF(a, 0.0);
    t := 0.0;
    WHILE t <= 35.0 DO
      r := a * Math.exp(b * t);
      x := r * Math.cos(t);
      y := r * Math.sin(t);
      Gr.LineToF(x, y, white);
      t := t + 0.1
    END
  END Do;

END LogSpiral.Do    System.Free LogSpiral ~
