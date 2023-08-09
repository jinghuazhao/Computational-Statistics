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

Now we intend to render `matplotlib.qmd`,
> ```
> ---
> title: "matplotlib demo"
> format:
>   html:
>     code-fold: true
> jupyter: python3
> ---
> 
> For a demonstration of a line plot on a polar axis, see @fig-polar.
> 
> ```{python}
> #| label: fig-polar
> #| fig-cap: "A line plot on a polar axis"
> 
> import numpy as np
> import matplotlib.pyplot as plt
> 
> r = np.arange(0, 2, 0.01)
> theta = 2 * np.pi * r
> fig, ax = plt.subplots(
>   subplot_kw = {'projection': 'polar'}
> )
> ax.plot(theta, r)
> ax.set_rticks([0.5, 1, 1.5, 2])
> ax.grid(True)
> plt.show()
> ```
> ```

which is done by

```bash
quarto render matplotlib.qmd
```

> Devezer B, Nardin LG, Baumgaertner B, Buzbas EO. Scientific discovery in a model-centric framework: Reproducibility, innovation, and epistemic diversity. PLoS One. 2019 May 15;14(5):e0216125. doi: 10.1371/journal.pone.0216125. eCollection 2019.
