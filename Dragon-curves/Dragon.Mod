MODULE Dragon;  (* hk  15 July 2024 *)   (* Dragon.Do 1 *)
(* Dragon curve. After a BASIC program 'DRAAK' from: Hans Lauwerier, Fractals, 1988 
	The command Dragon.Do accepts an integer parameter 0..15 for the order of the curve.
	The order of the curve is the number of times the paper slip is folded. *)

	IMPORT Math, In, Out, XY := XYplane, Gr := XYgraphics;
	
	CONST 
		pi = 3.1415926535;
		white = Gr.white;
		a = 1.7453;           (* angles of dragon curve (1.7453 radians = 100 degree) *)
	(*a = 1.570796327;*)    (* for right angles:  a = pi/2 *)

	VAR
		p: INTEGER;  (* order of dragon curve; used as power of 2 *)
		pF: REAL;    (* internally used form for p: FLT(p) *)

	PROCEDURE Do* ;
		VAR m, n, d, s: INTEGER;
			b, h, x, y, end: REAL;
	BEGIN
		In.Open;  In.Int(p);  (* any integer in {0..15} *)
		IF ~In.Done THEN p := 9 END;  pF := FLT(p);
		IF p <= 9 THEN
			XY.OpenH(478);  Gr.SetCoords(-1.5, -1.9, 2.5, 1.1)  (* aspect ratio 4:3 *)
		ELSIF (10 <=p) & (p <= 12) THEN
			XY.OpenH(638);  Gr.SetCoords(-2.1, -0.8, 1.9, 3.2)  (* aspect ratio 1:1 *)
		ELSIF (p = 13) OR (p = 14) THEN
			XY.OpenH(638);  Gr.SetCoords(-3.2, -1.8, 0.8, 2.2)  (* aspect ratio 1:1 *)
		ELSIF (p = 15) THEN
			XY.OpenH(753);  Gr.SetCoords(-3.0, -4.2, 2.0, 1.8)  (* aspect ratio 5:6 *)
		ELSE
			Out.String("Parameter error: p must be in { 0...15 }."); Out.Ln
		END;
		IF (0 <= p) & (p <= 15) THEN
			XY.Clear;
			h := Math.power(2.0, -pF/2.0);
			b := pi - a;  x := h;  y := 0.0;  s := 0;
			Gr.LineF(0.0, 0.0, x, y, white);
			n := 1;  end := Math.power(2.0, pF) - 1.0;
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

END Dragon.Do 4
