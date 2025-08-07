# Language notes

This page collects information on Visual Studio Code, C, C++, Fortran, Java, Perl, python and R.

## Ada

Web: <https://www.adaic.org/>

From `hello.adb`,

```ada
with Ada.Text_IO;

procedure Hello is
begin
   Ada.Text_IO.Put_Line ("Hello, World!");
end Hello;
```

We run

```bash
gnatmake hello
hello
```

## BASIC

It is still possible to reflect the old language from here,

[https://sourceforge.net/projects/devos-studio/](https://sourceforge.net/projects/devos-studio/).

## C

There have been multiple instances for suggesting migration from`tempnam` to `mkstemp` (`/usr/include/stdlib.h` under Bash but not Windows) and `mktemp`
-- the following code illustrates its use under both Bash and Windows, Nevertheless these are not standard routines, one still needs to add
 `char *mktemp(char *)` for instance.
```c
#include <stdio.h>
#include <fcntl.h>      /* for open flags */
#include <limits.h>     /* for PATH_MAX */

int main(void)
{
        static char template[] = "/tmp/myfileXXXXXX";
        char fname[PATH_MAX];
        static char mesg[] =
                "Here's lookin' at you, kid!\n";        /* beats "hello, world" */
        int fd;

        strcpy(fname, template);
        mktemp(fname);

        /* RACE CONDITION WINDOW OPENS */

        printf("Filename is %s\n", fname);

        /* RACE CONDITION WINDOW LASTS TO HERE */

        fd = open(fname, O_CREAT|O_RDWR|O_TRUNC, 0600);
        write(fd, mesg, strlen(mesg));
        close(fd);

        /* unlink(fname); */

        return 0;
}
```

A script for testing UTF-8 support by PCRE,

```c
#include <pcre.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
    int supports_utf8;
    if (pcre_config (PCRE_CONFIG_UTF8, &supports_utf8)) {
        fprintf(stderr, "pcre_config() failed\n");
        exit(EXIT_FAILURE);
    }
    printf("UTF-8 is supported: %s\n", supports_utf8 ? "yes" : "no");
    exit(EXIT_SUCCESS);
}
// gcc $(pkg-config --cflags --libs libpcre) pcreutf.c
// ./a.out
// pcretest -C
```

The following is Timsort implementation,

```c
#include <stdio.h>

#define MIN_RUN 32

// 插入排序算法
void insertionSort(int arr[], int left, int right) {
    for (int i = left + 1; i <= right; i++) {
        int key = arr[i];
        int j = i - 1;
        while (j >= left && arr[j] > key) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key;
    }
}

// 归并函数
void merge(int arr[], int left, int mid, int right) {
    int len1 = mid - left + 1;
    int len2 = right - mid;
    int L[len1], R[len2];

    for (int i = 0; i < len1; i++)
        L[i] = arr[left + i];
    for (int j = 0; j < len2; j++)
        R[j] = arr[mid + 1 + j];

    int i = 0, j = 0, k = left;

    while (i < len1 && j < len2) {
        if (L[i] <= R[j])
            arr[k++] = L[i++];
        else
            arr[k++] = R[j++];
    }

    while (i < len1)
        arr[k++] = L[i++];
    while (j < len2)
        arr[k++] = R[j++];
}

// Timsort 算法
void timSort(int arr[], int n) {
    for (int i = 0; i < n; i += MIN_RUN)
        insertionSort(arr, i, (i + MIN_RUN - 1) < n ? (i + MIN_RUN - 1)
                      : (n - 1));

    for (int size = MIN_RUN; size < n; size *= 2) {
        for (int left = 0; left < n; left += 2 * size) {
            int mid = left + size - 1;
            int right = (left + 2 * size - 1) < (n - 1) ?
              (left + 2 * size - 1) : (n - 1);
            merge(arr, left, mid, right);
        }
    }
}

int main() {
    int arr[] = {12, 11, 13, 5, 6, 7};
    int n = sizeof(arr) / sizeof(arr[0]);
    printf("Original array: ");
    for (int i = 0; i < n; i++)
        printf("%d ", arr[i]);

    timSort(arr, n);

    printf("\nSorted array: ");
    for (int i = 0; i < n; i++)
        printf("%d ", arr[i]);
    return 0;
}
```

y `gcc timsort.c -o timsort` and `timsort` to get

```
Original array: 12 11 13 5 6 7
Sorted array: 5 6 7 11 12 13 14:40
```


## C++

The use of Google Test is noted here,

Web: [https://github.com/google/googletest](https://github.com/google/googletest).

```bash
wget -qO- https://github.com/google/googletest/archive/refs/tags/release-1.11.0.tar.gz | \
tar xvfz -
cd googletest-release-1.11.0
mkdir build && cd build
build ..
make
# amending set(CMAKE_INSTALL_PREFIX "/rds/user/jhz22/hpc-work") in `cmake_install.cmake`
make install
```
Now it is possible to compile R/glmnet 4.1-3, i.e., `find_package(GTest 1.11 CONFIG REQUIRED)` of `src/glmnetpp/CMakeLists.txt`.

## Fortran

Information on modernising Fortran could be very useful in foreign language calls (e.g., R),

http://fortranwiki.org/fortran/show/Modernizing+Old+Fortran.

Debugging Fortran code

* gdb https://undo.io/resources/debugging-fortran-code-gdb/
* valgrind
```
program segfault1
  implicit none
  real, dimension(10) :: a
  integer :: i
  a = 0.
  do i = 1, 12
     a(i) = i
     print*,a(i)
  end do
end program segfault1

! gfortran -g -Wall -Wextra -Wimplicit-interface -fPIC -fmax-errors=1 -fcheck=all -fbacktrace segfault1.f90 -o segfault1
! valgrind  --leak-check=full --dsymutil=yes --track-origins=yes ./segfault1
! MacOS --dsymutil=yes:
! valgrind  --leak-check=full --dsymutil=yes --track-origins=yes ./segfault1
```

## Java

The IDE of choice is NetBeans (e.g., DEPICT and JAM); however 8.1 from `apt install` under Ubuntu 18.04 crashes
so it is suggested to download directly from https://netbeans.org/downloads/. To enable JDK it is helpful to specify `--javahome` option.
```bash
sudo ./netbeans-8.2-linux.sh --javahome /usr/lib/jvm/java-8-oracale
```
or start with `netbeans --javahome /usr/lib/jvm/java-8-oracle` (more convenient to set `alias netbeans='netbeans --javahome /usr/lib/jvm/java-8-oracle'` at `.bashrc`).

NetBeans 9.0 is currently available from https://netbeans.apache.org/download/nb90/; the .zip file can be downloaded and unpacked for use.

For software such as `cutadapt` cython is required,
```bash
sudo apt install cython
```

## JavaScript

A current JavaScript/TypeScript interpreter is deno, <https://anaconda.org/conda-forge/deno/files>.

```bash
wget https://anaconda.org/conda-forge/deno/1.40.2/download/linux-64/deno-1.40.2-hfc7925d_0.conda -O deno.conda
unzip deno.conda
tar --use-compress-program=unzstd -xvf pkg-deno-1.40.2-hfc7925d_0.tar.zst
deno --version
```

giving

```
deno 1.40.2 (release, x86_64-unknown-linux-gnu)
v8 12.1.285.6
typescript 5.3.3
```

The mermaid diagram is illustrated with [mermaid.html](src/mermaid.html) using code available from here, <https://cdnjs.cloudflare.com/ajax/libs/mermaid/8.0.0/mermaid.min.js>.

The call can be embedded in markdown document,

```
<script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
  mermaid.initialize({ startOnLoad: true });
</script>
```

The hello world example with plotly.js is <https://plot.ly/javascript/getting-started/#hello-world-example> and the 3D diagram is with [3d-scatter.html](src/3d-scatter.html) based on <https://plot.ly/javascript/3d-scatter-plots/>.

The base64 encode/decode is with <https://www.base64encode.org/> & <https://www.base64decode.org/>.

## Perl
```bash
sudo perl -MCPAN -e shell
install DBI
```
for instance, as used in [VEP](https://jinghuazhao.github.io/software-notes/AA/#vep).

Another notable example is circos, [http://circos.ca](http://circos.ca) and its [Google group](https://groups.google.com/g/circos-data-visualization),

```bash
wget -qO- http://www.circos.ca/distribution/circos-current.tgz | \
tar xvfz -
cd circos-0.69-9
bin/circos --modules
wget -qO- http://circos.ca/distribution/circos-tutorials-current.tgz | \
tar xvfz -
wget -qO- http://www.circos.ca/distribution/circos-tools-current.tgz | \
tar xvfz -
```

The following required modules can be installed

```perl
Config::General (v2.50 or later)
Font::TTF
GD
List::MoreUtils
Math::Bezier
Math::Round
Math::VecStat
Params::Validate
Readonly
Regexp::Common
Set::IntSpan (v1.16 or later)
Text::Format
```

and we can enter the example/ directory to run its script. The [CircosAPI](https://github.com/kylase/CircosAPI) module requires `namespace::autoclean`, `Moose`, `JSON::PP` and `String::Util`.

## Python

To disable upgrade of pip, add 
```config
[global]
disable-pip-version-check = True
```
option to `$HOME/.config/pip/pip.conf`

To install a particular version of package, e.g.,
```bash
sudo -H pip install pandas==0.20.1
```
which is required by DEPICT's `munge_sumstats.py`. Other pip options include `uninstall`.

The python programs in [agotron_detector](https://github.com/ncrnalab/agotron_detector) requires MySQL and can be installed as follows,
```bash
sudo apt-get install python-dev libmysqlclient-dev
sudo pip install MySQL-python
```

It is necessary to use --user option without super-user privilege.

PyStan is available with `pip install pystan` which uses matplotlib, https://github.com/matplotlib and Tkinter, established with `sudo apt install python-tk` or `sudo apt install python3-tk`.

```python
import pystan

schools_code = """
data {
    int<lower=0> J; // number of schools
    real y[J]; // estimated treatment effects
    real<lower=0> sigma[J]; // s.e. of effect estimates
}
parameters {
    real mu;
    real<lower=0> tau;
    real eta[J];
}
transformed parameters {
    real theta[J];
    for (j in 1:J)
    theta[j] = mu + tau * eta[j];
}
model {
    eta ~ normal(0, 1);
    y ~ normal(theta, sigma);
}
"""

schools_dat = {'J': 8,
               'y': [28,  8, -3,  7, -1,  1, 18, 12],
               'sigma': [15, 10, 16, 11,  9, 11, 10, 18]}

sm = pystan.StanModel(model_code=schools_code)
fit = sm.sampling(data=schools_dat, iter=1000, chains=4)

import matplotlib.pyplot as plt
def plotGraph():
      fig = fit.plot()
      # plt.show()
      # use the save button or the following command,
      # f.savefig("foo.pdf", bbox_inches='tight')
      return fig

from matplotlib.backends.backend_pdf import PdfPages
pp = PdfPages('foo.pdf')
f = plotGraph()
pp.savefig(f)
pp.close()
```
To install jupyter-book,
```bash
module load python/2.7.10
python -m pip install jupyter-book --user
```
and we can check for $HOME/.local/lib/python2.7/site-packages and start from /home/jhz22/.local/bin. We can install notebook similarly.
```bash
python -m pip install notebook --user
```
Owing to recent changes, it is more appropriate to use python3
```bash
module load python/3.5
export PATH=$PATH:$HOME/.local/bin
export PYTHONPATH=/usr/local/Cluster-Apps/python/3.5.1/lib/python3.5/site-packages:$HOME/.local/lib/python3.5/site-packages
python3 -m pip install jupyter-book --user
```

To convert from `parquet` to `csv` is done as follows,

```python
import pandas as pd
import pyspark
import pyarrow
import sys
import os
    
fn = sys.argv[1]
print(fn)

df = pd.read_parquet(fn)

outfn = "".join("GTEx_Analysis_v8_EUR_eQTL_all_associations_csv/" + os.path.splitext(os.path.basename(fn))[0] + ".csv") 
print(outfn)

df.to_csv(outfn)
```

## R

Information on R and RStudio can be seen from installation section of this, [https://jinghuazhao.github.io/Computational-Statistics/INSTALL/](https://jinghuazhao.github.io/Computational-Statistics/INSTALL/).

The use of multi-byte string needs specific handling, e.g.,
```bash
# on Bash
iconv myfile -f UTF-8 -t ISO-8859-1 -c
```
and
```r
# in R
Sys.setlocale("LC_ALL", "C")
```
See https://stackoverflow.com/questions/4993837/r-invalid-multibyte-string

**plotly**

It requires a number of software,
```bash
sudo dnf install udunits2-devel
sudo dnf install cairo-devel
sudo dnf install gdal gdal-devel
sudo dnf install proj-devel proj-static
sudo dnf install geos geos-devel
```
to be followed by
```r
install.packages("plotly",depend=TRUE,repos="https://cran.r-project.org")
```

**Calls from R**

* Basic examples using OpenMP with R, for C, C++, F77, and Fortran 2003 using Romp, https://github.com/wrathematics/Romp
* RFI: R to Modern Fortran Interface, https://github.com/t-kalinowski/RFI
* Stanford Utility Tools for R packages using Fortran, https://bnaras.github.io/SUtools/articles/SUtools.html

Package examples for Fortran,
* https://cran.r-project.org/web/packages/Delaporte/index.html.
* https://cran.r-project.org/web/packages/spam/index.html
* https://cran.r-project.org/web/packages/spam64/index.html

Documentation
* https://www.avrahamadler.com/2018/12/09/the-need-for-speed-part-1-building-an-r-package-with-fortran/
* https://www.avrahamadler.com/2018/12/23/the-need-for-speed-part-2-c-vs-fortran-vs-c/
* https://www.sciencedirect.com/science/article/pii/S2352711018300785?via%3Dihub

**R packages**

See [https://r-pkgs.org/index.html](https://r-pkgs.org/index.html).

## shinyapps

Web: [https://www.shinyapps.io/](https://www.shinyapps.io/), [Shiny examples](https://github.com/rstudio/shiny-examples)

The `hello world` version is as follows,

```r
library(shiny)
ui <- fluidPage(
  "Hello, world!"
)
server <- function(input, output, session) {
}
shinyApp(ui, server)
```

Suppose our a directory (called shinyapps here) contains files `ui.R` and `server.R` (or combined in `app.R`).

Go the web site, and register an account with email address. Login from [https://www.shinyapps.io/admin/#/login](https://www.shinyapps.io/admin/#/login) and the following information is available:

### Step 1 – Install rsconnect

The rsconnect package can be installed directly from CRAN. To make sure you have the latest version run following code in your R console:

```r
install.packages('rsconnect')
```

### Step 2 – Authorize Account

The rsconnect package must be authorized to your account using a token and secret. To do this, click the copy button below and we'll copy the whole command you need to your clipboard. Just paste it into your console to authorize your account. Once you've entered the command successfully in R, that computer is now authorized to deploy applications to your shinyapps.io account.

```r
rsconnect::setAccountInfo(name='your-account', token='your token', secret='your secret')
```

In the future, you can manage your tokens from the Tokens page the settings menu.

### Step 3 – Deploy

Once the rsconnect package has been configured, you're ready to deploy your first application. If you haven't written any applications yet, you can also checkout the Getting Started Guide for instructions on how to deploy our demo application. Run the following code in your R console.

```r
library(rsconnect)
rsconnect::deployApp('path/to/your/app')
```

The shiny page is then up as `https://your-account.shinyapps.io/shinyapps/`.

A more sophisticated Dashboard using the `Gapminer` dataset is copied here from R-bloggers.

```R
library(shiny)
library(dplyr)
library(purrr)
library(gapminder)
library(highcharter)

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  sidebarLayout(
    sidebarPanel(
      titlePanel("R Shiny Highcharts"),
      selectInput(
        inputId = "inContinent",
        label = "Continent:",
        choices = unique(gapminder$continent),
        selected = "Europe"
      ),
      selectInput(
        inputId = "inYearMin",
        label = "Start year:",
        choices = unique(gapminder$year)[1:length(unique(gapminder$year)) - 1],
        selected = min(gapminder$year)
      ),
      selectInput(
        inputId = "inYearMax",
        label = "End year:",
        choices = unique(gapminder$year)[2:length(unique(gapminder$year))],
        selected = max(gapminder$year)
      ),
      width = 3
    ),
    mainPanel(
      tags$h3("Latest stats:"),
      tags$div(
        tags$div(
          tags$p("# Countries:"),
          textOutput(outputId = "outNCountries")
        ) %>% tagAppendAttributes(class = "stat-card"),
        tags$div(
          tags$p("Median life exp:"),
          textOutput(outputId = "outMedLifeExp")
        ) %>% tagAppendAttributes(class = "stat-card"),
        tags$div(
          tags$p("Median population:"),
          textOutput(outputId = "outMedPop")
        ) %>% tagAppendAttributes(class = "stat-card"),
        tags$div(
          tags$p("Median GDP:"),
          textOutput(outputId = "outMedGDP")
        ) %>% tagAppendAttributes(class = "stat-card")
      ) %>% tagAppendAttributes(class = "stat-card-container"),
      tags$div(
        tags$h3("Summary stats:"),
        tags$div(
          tags$div(
            highchartOutput(outputId = "chartLifeExpByYear", height = 500)
          ) %>% tagAppendAttributes(class = "chart-card"),
          tags$div(
            highchartOutput(outputId = "chartGDPByYear", height = 500)
          ) %>% tagAppendAttributes(class = "chart-card"),
        ) %>% tagAppendAttributes(class = "base-charts-container")
      ) %>% tagAppendAttributes(class = "card-container"),
      tags$div(
        tags$h3("Drilldown:"),
        tags$div(
          highchartOutput(outputId = "chartDrilldown", height = 500)
        ) %>% tagAppendAttributes(class = "chart-card chart-card-full")
      ) %>% tagAppendAttributes(class = "card-container"),
      width = 9
    ) %>% tagAppendAttributes(class = "main-container")
  )
)

server <- function(input, output) {
  data_cards <- reactive({
    gapminder %>%
      filter(
        continent == input$inContinent,
        year == max(year)
      ) %>%
      summarise(
        nCountries = n_distinct(country),
        medianLifeExp = median(lifeExp),
        medianPopM = median(pop / 1e6),
        medianGDP = median(gdpPercap)
      )
  })
  
  data_charts <- reactive({
    gapminder %>%
      filter(
        continent == input$inContinent,
        between(year, as.integer(input$inYearMin), as.integer(input$inYearMax))
      ) %>%
      group_by(year) %>%
      summarise(
        medianLifeExp = round(median(lifeExp), 1),
        medianGDP = round(median(gdpPercap), 2)
      )
  })
  
  drilldown_chart_base_data <- reactive({
    gapminder %>%
      filter(
        continent == input$inContinent,
        year == max(year)
      ) %>%
      group_by(country) %>%
      summarise(
        pop = round(pop, 1)
      ) %>%
      arrange(desc(pop))
  })
  
  drilldown_chart_drilldown_data <- reactive({
    gapminder %>%
      filter(
        continent == input$inContinent,
        between(year, as.integer(input$inYearMin), as.integer(input$inYearMax))
      ) %>%
      group_nest(country) %>%
      mutate(
        id = country,
        type = "column",
        data = map(data, mutate, name = year, y = pop),
        data = map(data, list_parse)
      )
  })
  
  
  output$outNCountries <- renderText({
    data_cards()$nCountries
  })
  output$outMedLifeExp <- renderText({
    paste(round(data_cards()$medianLifeExp, 1), "years")
  })
  output$outMedPop <- renderText({
    paste0(round(data_cards()$medianPopM, 2), "M")
  })
  output$outMedGDP <- renderText({
    paste0("$", round(data_cards()$medianGDP, 2))
  })
  
  output$chartLifeExpByYear <- renderHighchart({
    hchart(data_charts(), "column", hcaes(x = year, y = medianLifeExp), color = "#0198f9", name = "Median life expectancy") |>
      hc_title(text = "Median life expectancy by year", align = "left") |>
      hc_xAxis(title = list(text = "Year")) |>
      hc_yAxis(title = list(text = "Life expectancy"))
  })
  
  output$chartGDPByYear <- renderHighchart({
    hchart(data_charts(), "line", hcaes(x = year, y = medianGDP), color = "#800000", name = "Median GDP") |>
      hc_title(text = "Median GDP by year", align = "left") |>
      hc_xAxis(title = list(text = "Year")) |>
      hc_yAxis(title = list(text = "GDP"))
  })
  
  output$chartDrilldown <- renderHighchart({
    hchart(
      drilldown_chart_base_data(),
      "column",
      hcaes(x = country, y = pop, drilldown = country),
      name = "Population"
    ) %>%
      hc_drilldown(
        allowPointDrilldown = TRUE,
        series = list_parse(drilldown_chart_drilldown_data())
      ) |>
      hc_colors(c("#004c5f")) |>
      hc_title(text = "Population report", align = "left") |>
      hc_xAxis(title = list(text = "")) |>
      hc_yAxis(title = list(text = "Population"))
  })
}

shinyApp(ui = ui, server = server)
```

and the `www/styles.css` is here,

```css
www/styles.css
@import url('https:/s.googleapis.com/css2?family=Poppins:ital,wght@0,700;1,400&display=swap');

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  -family: 'Poppins', sans-serif;
  -weight: 400;
}

.main-container {
  padding-top: 1rem;
}

.stat-card-container {
  display: flex;
  justify-content: space-between;
  column-gap: 1rem;
}

.stat-card {
  border: 2px solid #f2f2f2;
  border-bottom: 2px solid #0198f9;
  width: 100%;
  padding: 0.5rem 0 0.5rem 1rem;
}

.stat-card > p {
  text-transform: uppercase;
  color: #808080;
}

.stat-card > div.shiny-text-output {
  -size: 3rem;
  -weight: 700;
}

.card-container {
  padding-top: 2rem;
}

.base-charts-container {
  display: flex;
  justify-content: space-between;
  column-gap: 1rem;
}

.chart-card {
  border: 2px solid #f2f2f2;
  width: 50%;
}

.chart-card-full {
  width: 100%;
}
```

## TeX/LaTeX

It is most convient to convert Tex/LaTex formulas into MicroSoft Word equtions via pandoc, i.e.,
`pandoc README.md -o README.docx`.

See [https://pandoc.org/](https://pandoc.org/) and [https://pandoc.org/try/](https://pandoc.org/try/).

For Chinese language support, try

```bash
sudo apt-get install texlive-latex-base
sudo apt-get install latex-cjk-all
sudo apt-get install texlive-latex-extra
sudo apt-get install texmaker
sudo apt-get install texlive-xetex
sudo apt-get install texlive-publishers
```

Now change latex to xelatex from Texmaker.
```latex
\documentclass{article}
\usepackage(xeCJK}
\begin{document}
How are you?你好吗？
\LaTeX
\end{document}
```

## typescript

First, create hello.ts with two lines,
```ts
#!/usr/bin/env ts-node
console.log('Hello world!');
```
and set up the environment,

```
npm install -g npm
npm install typescript ts-node -g
chmod +x hello.ts
hello.ts
```

## Visual Studio Code

It is available from <https://code.visualstudio.com/download>, so we could download a .tar.gz file and unpack.

There is a pointer from https://github.com/Microsoft/vscode to https://code.visualstudio.com/Download. Once downloaded, it can be installed with
```bash
sudo dpkg -i code_1.23.1-1525968403_amd64.deb
```
but it requires `libgconf-2-4`; when failed to install use `sudo apt --fix-broken install`.

See [https://code.visualstudio.com/docs/python/python-tutorial](https://code.visualstudio.com/docs/python/python-tutorial) for the hello world example.


## ChatGPT

We have `export OPENAI_API_KEY=$(grep sk ~/doc/OpenAI)`, and our first session:

```python
import os
import openai

openai.api_key = os.getenv("OPENAI_API_KEY")
if openai.api_key is None:
    raise ValueError("API key not found. Please set the OPENAI_API_KEY environment variable.")

question = input("What is your question? ")

response = openai.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=[
        {"role": "user", "content": question},
    ],
    max_tokens=512,
    n=1,
    stop=None,
    temperature=0.8,
)

print(response)
answer = response['choices'][0]['message']['content']
print("OpenAI: " + answer)
```

## CodeGPT

We need sign up/in for an API key from <https://platform.openai.com/overview>, e.g., via your MicrsoSoft account.

From `Visual Studio Code`, add extension `CodeGPT`; `Ctrl-Shit-p` to saarch for `CodeGPT: Set API Key` and enter the key given above from <https://platform.openai.com/account/api-keys>.

Then we create a file, start with a comment, e.g., '# to draw a forest plot' and `Ctrl-Shift-i` to obtain the code.

Here is one of the results given,

```r
# First, create a dataset with the relevant values for your forest plot
study_names <- c("Study A", "Study B", "Study C", "Study D")
odds_ratios <- c(1.2, 1.5, 0.8, 0.6)
lo_ci <- c(0.9, 1.0, 0.5, 0.3)
hi_ci <- c(1.5, 2.0, 1.2, 0.9)

# Combine data into a data frame
df <- data.frame(study_names, odds_ratios, lo_ci, hi_ci)

# Load the 'meta' package for the forest plot function
library(meta)

# Create the forest plot
forest(df$odds_ratios, ci.lb = df$lo_ci, ci.ub = df$hi_ci,
       slab = df$study_names, xlab = "Odds Ratio",
       main = "Forest Plot Example")
```

