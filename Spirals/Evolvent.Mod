MODULE Evolvent;  (* hk  21 July 2024 *)
(* Evolvent spiral (a.k.a. Involute of a circle). Version with XYgraphics.LineToF().
  The command Evolvent.Do accepts a REAL parameter 0.1 ... 1.3 for the radius of the circle.
  After a BASIC program 'WIKKEL' from: Hans Lauwerier, Fractals, 1988 *)

  IMPORT Math, In, Out, XY := XYplane, Gr := XYgraphics;

  CONST 
    pi = 3.1415926535;
    white = Gr.white;
 
  PROCEDURE Do* ;
    VAR
      r: REAL;  (* radius of circle *)
      n, t, x, y: REAL;
  BEGIN
    In.Open;  In.Real(r);
    IF ~In.Done THEN r := 1.0 END;
    IF r <= 1.3 THEN
      XY.OpenH(XY.square + 17);  (* with + 17 the tangents are drawn more flush with the circle *)
      XY.Clear;
      Gr.SetCoords(-6.0,-8.0, 10.0, 8.0);
      Gr.Circle(0.0, 0.0, r);
      Gr.MoveToF(r, 0.0);
      n := 0.0;
      WHILE n < 100.0 DO
        t := 2.0 * pi * n / 80.0;
        x := r * (Math.cos(t) + t * Math.sin(t));
        y := r * (Math.sin(t) - t * Math.cos(t));
        Gr.LineToF(x, y, white);  (* evolvent *)
        IF FLOOR(n) MOD 10 = 0 THEN Gr.LineF(r * Math.cos(t), r * Math.sin(t), x, y, white) END;  (* tangents *)
        n := n + 1.0
      END
    ELSE
      Out.String("Parameter error: r is at most 1.3"); Out.Ln
    END
  END Do;

END Evolvent.Do 1.25       System.Free Evolvent ~
