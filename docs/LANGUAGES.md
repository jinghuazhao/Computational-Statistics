# Language notes

This page collects information on Visual Studio Code, C, Fortran, Java, Perl, and R.

## Visual Studio Code

There is a pointer from https://github.com/Microsoft/vscode to https://code.visualstudio.com/Download. Once downloaded, it can be installed with
```bash
sudo dpkg -i code_1.23.1-1525968403_amd64.deb
```
but it requires `libgconf-2-4`; when failed to install use `sudo apt --fix-broken install`.

See [https://code.visualstudio.com/docs/python/python-tutorial](https://code.visualstudio.com/docs/python/python-tutorial) for the hello world example.

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

The mermaid diagram is illustrated with [mermaid.html](src/mermaid.html) using code available from here, https://cdnjs.cloudflare.com/ajax/libs/mermaid/8.0.0/mermaid.min.js.

The hello world example with plotly.js is https://plot.ly/javascript/getting-started/#hello-world-example and the 3D diagram is with [3d-scatter.html](src/3d-scatter.html) based on https://plot.ly/javascript/3d-scatter-plots/..

The base64 encode/decode is with [https://www.base64encode.org/](https://www.base64encode.org/)/[https://www.base64decode.org/](https://www.base64decode.org/).

## Perl
```bash
sudo perl -MCPAN -e shell
install DBI
```
for instance, as used in [VEP](https://github.com/jinghuazhao/software-notes/blob/master/AA.md).

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

## R

Information on R and RStudio can be seen from installation section of this, https://github.com/jinghuazhao/Computational-Statistics.

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

## TeX/LaTeX

It is most convient to convert Tex/LaTex formulas into MicroSoft Word equtions via pandoc, i.e.,
`pandoc README.md -o README.docx`.

See https://pandoc.org/ and https://pandoc.org/try/.
