# Dragon curves with rounded corners

Dragon1.Mod contains Oberon source code for dragon curves with rounded corners in the Oberon System. <br>
You can give the command Dragon1.Do an optional integer argument to determine the order of the curve.

There is still a problem with orders that are even numbers < 14 (e.g. see the second screenshot below for order 10).<br>
Even number orders ≥ 14 do produce drawings, but only half the size (actually they more resemble labradoodles than dragons ;-)

The module makes use of XYgraphics.Mod and also of XYplane.Mod and Math.Mod (in my repository Oberon-07).

Be sure to use the corrected [Math.ln(x)](https://github.com/hansklav/Oberon-07-Math.ln) if you use this function in the implementation of [Math.power(x, e)](https://github.com/hansklav/Oberon-07/blob/master/Math.Mod).
<br>

![Screenshot](Dragon1a.png)

![Screenshot](Dragon1b.png)

![Screenshot](Dragon1c.png)

<br>
