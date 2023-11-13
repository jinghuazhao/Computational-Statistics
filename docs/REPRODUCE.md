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

To install for Ubuntu, 

```bash
sudo snap install pdftk       # version 2.02-4, or
sudo apt  install pdftk-java  # version 3.2.2-1
```

and for Fedora, `sudo dnf install pdftk-java`.

```bash
pdftk src.pdf dump_data output bookmarks.txt
pdftk target.pdf update_info bookmarks.txt output target-bm.pdf
```

## quarto

This is extensively documented under Linux, <https://cambridge-ceu.github.io/csd3/applications/quarto.html>.

Under Windows, however it is simpler which involves these steps

1. Install R, e.g., R-4.3.1

    > Optionally, one installs RStudio or Visual Studio Code (Extension Quarto available, ctrl-+/- to enlarge/shrink fonts).

2. Install python from <https://www.python.org/downloads/>

    > ```
    > rem  Program files\quarto\bin\tools
    > deno upgrade
    > py -m pip install tinytex
    > py -m pip install jupyter
    > py -m pip install numpy
    > py -m pip install matplotlib
    > ```

3. Install quarto, e.g., quato-1.3.450, from <https://quarto.org>

Now we intend to render `matplotlib.qmd` adapted from <https://quarto.org>, rendered by `quarto render matplotlib.qmd`.
<div class="sourceCode" id="cb"><pre class="sourceCode markdown code-with-copy"><code class="sourceCode markdown"><span id="cb-1"><a href="#cb-1" aria-hidden="true" tabindex="-1"></a><span class="co">---</span></span>
<span id="cb-2"><a href="#cb-2" aria-hidden="true" tabindex="-1"></a><span class="an">title:</span><span class="co"> "matplotlib demo"</span></span>
<span id="cb-3"><a href="#cb-3" aria-hidden="true" tabindex="-1"></a><span class="an">format:</span></span>
<span id="cb-4"><a href="#cb-4" aria-hidden="true" tabindex="-1"></a><span class="co">  html:</span></span>
<span id="cb-5"><a href="#cb-5" aria-hidden="true" tabindex="-1"></a><span class="co">    code-fold: true</span></span>
<span id="cb-6"><a href="#cb-6" aria-hidden="true" tabindex="-1"></a><span class="an">jupyter:</span><span class="co"> python3</span></span>
<span id="cb-7"><a href="#cb-7" aria-hidden="true" tabindex="-1"></a><span class="co">---</span></span>
<span id="cb-8"><a href="#cb-8" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb-9"><a href="#cb-9" aria-hidden="true" tabindex="-1"></a>For a demonstration of a line plot on a polar axis, see @fig-polar.</span>
<span id="cb-10"><a href="#cb-10" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb-11"><a href="#cb-11" aria-hidden="true" tabindex="-1"></a><span class="in">```{python}</span></span>
<span id="cb-12"><a href="#cb-12" aria-hidden="true" tabindex="-1"></a><span class="in">#| label: fig-polar</span></span>
<span id="cb-13"><a href="#cb-13" aria-hidden="true" tabindex="-1"></a><span class="in">#| fig-cap: "A line plot on a polar axis"</span></span>
<span id="cb-14"><a href="#cb-14" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb-15"><a href="#cb-15" aria-hidden="true" tabindex="-1"></a><span class="in">import numpy as np</span></span>
<span id="cb-16"><a href="#cb-16" aria-hidden="true" tabindex="-1"></a><span class="in">import matplotlib.pyplot as plt</span></span>
<span id="cb-17"><a href="#cb-17" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb-18"><a href="#cb-18" aria-hidden="true" tabindex="-1"></a><span class="in">r = np.arange(0, 2, 0.01)</span></span>
<span id="cb-19"><a href="#cb-19" aria-hidden="true" tabindex="-1"></a><span class="in">theta = 2 * np.pi * r</span></span>
<span id="cb-20"><a href="#cb-20" aria-hidden="true" tabindex="-1"></a><span class="in">fig, ax = plt.subplots(</span></span>
<span id="cb-21"><a href="#cb-21" aria-hidden="true" tabindex="-1"></a><span class="in">  subplot_kw = {'projection': 'polar'} </span></span>
<span id="cb-22"><a href="#cb-22" aria-hidden="true" tabindex="-1"></a><span class="in">)</span></span>
<span id="cb-23"><a href="#cb-23" aria-hidden="true" tabindex="-1"></a><span class="in">ax.plot(theta, r)</span></span>
<span id="cb-24"><a href="#cb-24" aria-hidden="true" tabindex="-1"></a><span class="in">ax.set_rticks([0.5, 1, 1.5, 2])</span></span>
<span id="cb-25"><a href="#cb-25" aria-hidden="true" tabindex="-1"></a><span class="in">ax.grid(True)</span></span>
<span id="cb-26"><a href="#cb-26" aria-hidden="true" tabindex="-1"></a><span class="in">plt.show()</span></span>
<span id="cb-27"><a href="#cb-27" aria-hidden="true" tabindex="-1"></a><span class="in">```</span></span>
</div>
## Reference

Devezer B, Nardin LG, Baumgaertner B, Buzbas EO. Scientific discovery in a model-centric framework: Reproducibility, innovation, and epistemic diversity. *PLoS One*. 2019 May 15;14(5):e0216125. doi: 10.1371/journal.pone.0216125. eCollection 2019.
