# Dragon curves with rounded corners

[Dragon curves](https://mathworld.wolfram.com/DragonCurve.html) are interesting space filling curves that you can approximate by endlessly folding a slip of paper. Apparently I'm not the only one who is fascinated by them; [Donald Knuth](https://en.wikipedia.org/wiki/Donald_Knuth) has one decorating a wall in his home: https://www.youtube.com/watch?v=v678Em6qyzk (and yes, it has a bug).

Dragon1.Mod contains Oberon source code for dragon curves with rounded corners in the Oberon System. <br>
The command Dragon1.Do accepts an optional integer argument to determine the order of the curve.

The module makes use of XYgraphics.Mod (in this repo) and also of XYplane.Mod and Math.Mod (in my repo Oberon-07).

Be sure to use the corrected [Math.ln(x)](https://github.com/hansklav/Oberon-07-Math.ln) if you use this function in the implementation of [Math.power(x, e)](https://github.com/hansklav/Oberon-07/blob/master/Math.Mod).

With RISC Project Oberon 2013 firmware for FPGA and emulators thereof dated before July 2024 there is a problem with the rendering of dragon curves with orders that are even numbers < 14 (e.g. see the second screenshot below for order 10). Even number orders ≥ 14 do produce dragons, but considerably smaller (see the third screenshot; actually they more resemble labradoodles than dragons ;-)<br>
The newest firmware and updated emulators do not have this issue.

For reference and comparison I also added the original BASIC source by Hans Lauwerier (DRAAK1.BAS) and a Python implementation of it (dragon1.py).
<br>

![Screenshot](Dragon1a.png)

![Screenshot](Dragon1b.png)

![Screenshot](Dragon1c.png)

<br>
