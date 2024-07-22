# Several types of Spirals

Although spirals aren't fractals both are seen in living and lifeless nature, e.g. in ammonites and galaxies. Many spirals have self-similar properties, 
just like fractals. 

Already Archimedes (287-212 BCE) studied spirals and one kind of spiral is named after him: the 
[Archimedean or arithmetic spiral](https://en.wikipedia.org/wiki/Archimedean_spiral), in which the radius <span style="font-family:monospace">r</span> changes linearly with the arc <span style="font-family:monospace">φ</span>:<br>
<blockquote style="font-family:monospace">r = a·φ</blockquote>
The grooves of a gramophone record and the turns of a rolled ribbon are examples of Archimedean spirals.
The modules ArchiSpiral0.Mod and ArchiSpiral.Mod are based on ARCHI.BAS.
<br><br>
Another kind of spiral is the [evolvent or involute of a circle](https://proofwiki.org/wiki/Parametric_Equation_of_Involute_of_Circle) <nbsp></nbsp>(Dutch: 'wikkellijn, afwikkelkromme'). It can be constructed by the end of an unwinding string wound around a cilinder.
See WIKKEL.BAS and Evolvent.Mod.

The most abundant spiral in nature is the [growth spiral or logarithmic spiral](https://en.wikipedia.org/wiki/Logarithmic_spiral), in which the logarithm of the radius <span style="font-family:monospace">r</span> changes linearly with the arc <span style="font-family:monospace">φ</span>:

<blockquote style="font-family:monospace">ln(r) = a·φ</blockquote>

In the program we use an equivalent equation to calculate <span style="font-family:monospace">r</span>:

<blockquote style="font-family:monospace">r = exp(a·φ)</blockquote>

Logarithmic spirals are self-similar: they look the same at every scale. The Swiss mathematician Jacob Bernoulli (1654-1705) was so impressed by this property that he called this type of spiral <i>spira mirabilis</i> (wonderful spiral).
