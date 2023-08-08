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

## quanto

This is extensively documented under Linxu, <https://cambridge-ceu.github.io/csd3/applications/quarto.html>.

Under Windows, however it is relatively simple involving these steps

1. Install R, e.g., R-4.3.1
2. Install quarto, e.g., quato-1.3.450, from <https://quarto.org>
3. Install python from <https://www.python.org/downloads/>

```
# Program files\quarto\bin\tools
deno upgrade
py -m pip install tinytex
py -m pip install jupyter
py -m pip install numpy
py -m pip install matplotlib
quarto render matplotlib.qmd
```
Optionally, one install RStudio or Visual Studio Code (code ctrl-+/- to enlarge/shrink fonts).

> Devezer B, Nardin LG, Baumgaertner B, Buzbas EO. Scientific discovery in a model-centric framework: Reproducibility, innovation, and epistemic diversity. PLoS One. 2019 May 15;14(5):e0216125. doi: 10.1371/journal.pone.0216125. eCollection 2019.
