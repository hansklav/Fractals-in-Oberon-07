MODULE ArchiSpiral;  (* hk  13 July 2024 *)
(* Archimedean spiral (a.k.a. arithmetic spiral). Version with Gr.LineToF( ).
   After a BASIC program 'ARCHI' from: Hans Lauwerier, Fractals, 1988 *)

  IMPORT Math, In, XY := XYplane, Gr := XYgraphics;

  CONST 
    pi = 3.1415926535;
    a = 0.1;
    white = Gr.white;
 
  PROCEDURE Do* ;
    VAR r, t, x, y: REAL;
  BEGIN
    XY.OpenH(XY.square);  XY.Clear;
    Gr.SetCoords(-9.0, -9.0, 9.0, 9.0);
    Gr.MoveToF(0.0, 0.0);
    t := 0.0;
    WHILE t <= 16.0*pi DO
      r := a * t;
      x := r * Math.cos(t);
      y := r * Math.sin(t);
      Gr.LineToF(x, y, white);
      t := t + 0.1
    END
  END Do;

END ArchiSpiral.Do   System.Free ArchiSpiral ~
