MODULE SierpinskiSieve; (* hk  30 July 2024 *)	(* SierpinskiSieve.Do		ORP.Compile *)
(* Sierpinski Sieve, by the Polish mathematician Waclaw Sierpinski (1882-1969).
	 After a BASIC program 'SIER' from: Hans Lauwerier, Fractals, 1988 *)

	IMPORT Math, In, XY := XYplane, Gr := XYgraphics;

	CONST P = 10;

	PROCEDURE IntPow (n, e: INTEGER): INTEGER;  (* Compute n^e;  e >= 0 *)
		VAR p: INTEGER;
	BEGIN p := 1;
		WHILE e > 0 DO
			IF ODD(e) THEN p := p * n END;
			n := n * n;  e := e DIV 2 
		END
	RETURN p
	END IntPow;

	PROCEDURE Do* ;
		CONST
			pi = 3.1415926535;
			white = Gr.white;
		VAR 
			T: ARRAY P+1 OF INTEGER;
			k, L, m, n, n1: INTEGER;
			a, d1, d2, x, y, u1, v1, u2, v2: REAL;
	BEGIN
		In.Open;  In.Int(p);
		IF ~In.Done OR (p < 0) OR (p > P) THEN p := P END;

		XY.OpenH(XY.ar43);  (* 4:3 aspect ratio *)
		XY.Clear;
		Gr.SetCoords(-2.6, -2.4, 2.6, 1.5);

		a := Math.sqrt(3.0);
		FOR m := 0 TO P DO
			FOR n := 0 TO IntPow(3, m) - 1 DO
				n1 := n;
				FOR L := 0 TO m-1 DO T[L] := n1 MOD 3; n1 := n1 DIV 3 END;
				x := 0.0;  y := 0.0;
				FOR k := 0 TO m-1 DO
					d1 := Math.power(2.0, FLT(k));
					x := x + Math.cos(FLT((4*T[k]+1))*pi/6.0) / d1;
					y := y + Math.sin(FLT((4*T[k]+1))*pi/6.0) / d1
				END;
				d2 := Math.power(2.0, FLT(m+1));
				u1 := x + a/d2;    u2 := x - a/d2;
				v1 := y - 1.0/d2;  v2 := y + 1.0/Math.power(2.0,FLT(m));
				Gr.LineF(u1, v1, x, v2, white);
				Gr.LineToF(u2, v1, white);	 
				Gr.LineToF(u1, v1, white)
			END
		END
	END Do;

END SierpinskiSieve.Do		System.Free SierpinskiSieve
