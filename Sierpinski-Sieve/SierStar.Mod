MODULE SierStar; (* hk  31 July 2024 *)
(* Prints ASCII star versions of the Sierpinski triangle; for Oberon System V5 *)

	IMPORT S := SYSTEM, In, Out; 
	
	CONST N = 32;  (* alternatives: 2, 4, 8, 16, 32, 64,  &c.       *)
							   (* if your terminal screen is large enough...    *)	

	PROCEDURE Do*;

		VAR i, n, x, y: INTEGER;

		PROCEDURE AND (a, b: INTEGER): INTEGER;
			VAR aSet, bSet: SET;
		BEGIN
			aSet := S.VAL(SET, a);
			bSet := S.VAL(SET, b);
		RETURN ORD(aSet * bSet)  (* SET intersection *)
		END AND;

	BEGIN n := 0;
		In.Open;	In.Int(n);
		IF ~In.Done OR (n <= 0) THEN n := N END;
		
		Out.Open;  Out.SetFont("Courier10.Fnt");  Out.SetImmediate(FALSE);
		
		FOR y := n - 1 TO 0 BY -1 DO
			FOR i := 0 TO y - 1 DO Out.Char(" ") END;
			x := 0;
			WHILE x + y < n DO
				IF AND(x, y) # 0 THEN
					Out.String("  ")
				ELSE
					Out.String("* ")
				END;
				INC(x)
			END;
			Out.Ln
		END
	END Do;

END SierStar.Do^	2	4	8	16	32	64	128

System.Free SierStar ~
