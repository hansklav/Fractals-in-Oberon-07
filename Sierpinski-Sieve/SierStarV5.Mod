MODULE SierStarV5;  (* IN V5 *)  (* hk  4 August 2024 *)
(* Prints ASCII star versions of the Sierpinski triangle; for Oberon System V5.
	Also illustrates the effect of Out.Immediate (Out.ToLog resets this and the font). *)

	IMPORT S := SYSTEM, In, Out;

	CONST defaultOrder = 4;

	PROCEDURE Do*;
		VAR order, size, x, y, i: INTEGER;
	BEGIN
		In.Open;  In.Int(order);
		IF ~ In.Done THEN order := defaultOrder END;

		Out.Open;  Out.SetFont("Courier10.Fnt");  Out.SetImmediate(FALSE);

		size := LSL(1, order);  (* size = 2^order *)
		FOR y := size - 1 TO 0 BY -1 DO
			FOR i := 0 TO y - 1 DO Out.Char(" ") END;
			x := 0;
			WHILE x + y < size DO
				IF ORD(S.VAL(SET, x) * S.VAL(SET, y)) # 0 THEN
					Out.String("  ")
				ELSE
					Out.String("* ")
				END;
				INC(x)
			END;
			Out.Ln
		END;
		Out.ToLog
	END Do;

END SierStarV5.Do^  0  1  2  3  4  5  6  7
