# Dragon curves with rounded corners

Dragon1.Mod contains Oberon source code for dragon curves with rounded corners in the Oberon System. <br>
The command Dragon1.Do accepts an optional integer argument to determine the order of the curve.

The module makes use of XYgraphics.Mod (in this repo) and also of XYplane.Mod and Math.Mod (in my repo Oberon-07).

Be sure to use the corrected [Math.ln(x)](https://github.com/hansklav/Oberon-07-Math.ln) if you use this function in the implementation of [Math.power(x, e)](https://github.com/hansklav/Oberon-07/blob/master/Math.Mod).

There is still a problem with orders that are even numbers < 14 (e.g. see the second screenshot below for order 10).<br>
Even number orders ≥ 14 do produce recognizable drawings, but only half the size (actually they more resemble labradoodles than dragons ;-)

To analyse this problem I implemented the same algorithm in Python (dragon1.py), and then nice dragons of both odd and even orders are drawn (albeit MUCH slower than in Oberon).<br>
For reference I also added the original BASIC source by Hans Lauwerier (DRAAK1.BAS), which correctly handles odd and even orders as well.
<br>

![Screenshot](Dragon1a.png)

![Screenshot](Dragon1b.png)

![Screenshot](Dragon1c.png)

<br>
