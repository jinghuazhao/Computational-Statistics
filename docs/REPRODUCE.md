# Reproducible research

a.k.a Literate programming.

* [bookdown](https://github.com/rstudio/bookdown).
* [CWEB](https://www-cs-faculty.stanford.edu/~knuth/cweb.html).
* [Jupyter](https://jupyter.org/).
* [knitr](https://yihui.org/knitr/).
* [noweb](https://github.com/nrnrnr/noweb) and its [Tufts site](https://www.cs.tufts.edu/~nr/noweb/).
* [Pweave and ptangle](http://mpastell.com/pweave/).
* [Sweave and Stangle](https://www.rdocumentation.org/packages/utils/versions/3.6.0/topics/Sweave).

An attempt to model reproducibility is Conceptualizing Reproducibility Using Simulations and Theory ([CRUST](https://github.com/gnardin/CRUST)).

## bookmarks for PDF

This is for Ubuntu,

```bash
sudo apt install pdftk-java
pdftk src.pdf dump_data output bookmarks.txt
pdftk target.pdf update_info bookmarks.txt output target-bm.pdf
```

## quarto

This is extensively documented under Linux, <https://cambridge-ceu.github.io/csd3/applications/quarto.html>.

Under Windows, however it is relatively simple involving these steps

1. Install R, e.g., R-4.3.1
2. Install quarto, e.g., quato-1.3.450, from <https://quarto.org>
3. Install python from <https://www.python.org/downloads/>

```bash
# Program files\quarto\bin\tools
deno upgrade
py -m pip install tinytex
py -m pip install jupyter
py -m pip install numpy
py -m pip install matplotlib
```
Optionally, one install RStudio or Visual Studio Code (Extension Quarto available, ctrl-+/- to enlarge/shrink fonts).

Now we intend to render `matplotlib.qmd` adapted from <https://quarto.org>,

<p>It contains a code block that uses braces around the language name (e.g.&nbsp;<code>```{python}</code>) are executable, and will be run by Quarto during render. Here is a simple example:</p>
<div class="sourceCode" id="cb1"><pre class="sourceCode markdown code-with-copy"><code class="sourceCode markdown"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="co">---</span></span>
<span id="cb1-2"><a href="#cb1-2" aria-hidden="true" tabindex="-1"></a><span class="an">title:</span><span class="co"> "matplotlib demo"</span></span>
<span id="cb1-3"><a href="#cb1-3" aria-hidden="true" tabindex="-1"></a><span class="an">format:</span></span>
<span id="cb1-4"><a href="#cb1-4" aria-hidden="true" tabindex="-1"></a><span class="co">  html:</span></span>
<span id="cb1-5"><a href="#cb1-5" aria-hidden="true" tabindex="-1"></a><span class="co">    code-fold: true</span></span>
<span id="cb1-6"><a href="#cb1-6" aria-hidden="true" tabindex="-1"></a><span class="an">jupyter:</span><span class="co"> python3</span></span>
<span id="cb1-7"><a href="#cb1-7" aria-hidden="true" tabindex="-1"></a><span class="co">---</span></span>
<span id="cb1-8"><a href="#cb1-8" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb1-9"><a href="#cb1-9" aria-hidden="true" tabindex="-1"></a>For a demonstration of a line plot on a polar axis, see @fig-polar.</span>
<span id="cb1-10"><a href="#cb1-10" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb1-11"><a href="#cb1-11" aria-hidden="true" tabindex="-1"></a><span class="in">```{python}</span></span>
<span id="cb1-12"><a href="#cb1-12" aria-hidden="true" tabindex="-1"></a><span class="in">#| label: fig-polar</span></span>
<span id="cb1-13"><a href="#cb1-13" aria-hidden="true" tabindex="-1"></a><span class="in">#| fig-cap: "A line plot on a polar axis"</span></span>
<span id="cb1-14"><a href="#cb1-14" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb1-15"><a href="#cb1-15" aria-hidden="true" tabindex="-1"></a><span class="in">import numpy as np</span></span>
<span id="cb1-16"><a href="#cb1-16" aria-hidden="true" tabindex="-1"></a><span class="in">import matplotlib.pyplot as plt</span></span>
<span id="cb1-17"><a href="#cb1-17" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb1-18"><a href="#cb1-18" aria-hidden="true" tabindex="-1"></a><span class="in">r = np.arange(0, 2, 0.01)</span></span>
<span id="cb1-19"><a href="#cb1-19" aria-hidden="true" tabindex="-1"></a><span class="in">theta = 2 * np.pi * r</span></span>
<span id="cb1-20"><a href="#cb1-20" aria-hidden="true" tabindex="-1"></a><span class="in">fig, ax = plt.subplots(</span></span>
<span id="cb1-21"><a href="#cb1-21" aria-hidden="true" tabindex="-1"></a><span class="in">  subplot_kw = {'projection': 'polar'} </span></span>
<span id="cb1-22"><a href="#cb1-22" aria-hidden="true" tabindex="-1"></a><span class="in">)</span></span>
<span id="cb1-23"><a href="#cb1-23" aria-hidden="true" tabindex="-1"></a><span class="in">ax.plot(theta, r)</span></span>
<span id="cb1-24"><a href="#cb1-24" aria-hidden="true" tabindex="-1"></a><span class="in">ax.set_rticks([0.5, 1, 1.5, 2])</span></span>
<span id="cb1-25"><a href="#cb1-25" aria-hidden="true" tabindex="-1"></a><span class="in">ax.grid(True)</span></span>
<span id="cb1-26"><a href="#cb1-26" aria-hidden="true" tabindex="-1"></a><span class="in">plt.show()</span></span>
<span id="cb1-27"><a href="#cb1-27" aria-hidden="true" tabindex="-1"></a><span class="in">```</span></span>

which is done by `quarto render matplotlib.qmd`.

> Devezer B, Nardin LG, Baumgaertner B, Buzbas EO. Scientific discovery in a model-centric framework: Reproducibility, innovation, and epistemic diversity. PLoS One. 2019 May 15;14(5):e0216125. doi: 10.1371/journal.pone.0216125. eCollection 2019.
