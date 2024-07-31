MODULE Koch; (* hk  30 July 2024 *)  (* Koch.Do^  0 1 2 3 4 5 6  7  100   ORP.Compile*   System.Free Koch ~ *)
(* Draws several orders of the Koch curve, one of the first fractals, 
	 described by the Swedish mathematician Helge von Koch (1904). 
	 After a BASIC program 'KOCH' from: Hans Lauwerier, Fractals, 1988 *)

	IMPORT Math, In, XY := XYplane, Gr := XYgraphics;

	CONST P = 6;	(* Default order of the Koch curve (and maximum in Oberon System V5) *)
	
	PROCEDURE IntPow (n, e: INTEGER): INTEGER;  (* Compute n^e;  e > 0 *)
		VAR p: INTEGER;
	BEGIN p := 1;
		WHILE e > 0 DO
			IF ODD(e) THEN p := p * n END;
			n := n * n;	 e := e DIV 2 
		END 
	RETURN p
	END IntPow;

	PROCEDURE Do* ;
		CONST
			pi = Math.pi;
			white = Gr.white;
		VAR 
			T: ARRAY P OF INTEGER;
			k, L, m, n, p, s: INTEGER;
			h, x, y: REAL;
	BEGIN
		In.Open;  In.Int(p);  IF ~In.Done OR (p < 0) OR (p > P) THEN p := P END;

		XY.OpenH(XY.ar43);  (* 4:3 aspect ratio *)
		XY.Clear;	 Gr.SetCoords(-0.1, -0.4, 1.1, 0.5);

		h := Math.power(3.0, FLT(-p));
		Gr.MoveToF(0.0, 0.0);
		FOR n := 0 TO IntPow(4, p) - 1 DO
			(* Notation in quarterly (base 4) system *)
			m := n;  FOR L := 0 TO p-1 DO T[L] := m MOD 4; m := m DIV 4 END;
			(* Determinination of direction of line segment n *)
			s := 0;  FOR k := 0 TO p-1 DO s := s + (T[k]+1) MOD 3 - 1 END;
			(* Drawing of line segment n *)
			x := x + Math.cos( pi*FLT(s)/3.0 ) * h;
			y := y + Math.sin( pi*FLT(s)/3.0 ) * h;
			Gr.LineToF(x, y, white)
		END
	END Do;

END Koch.
