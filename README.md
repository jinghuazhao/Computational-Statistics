# Computational-Statistics

Online resources for computational statistics

This is the leap board for the following libraries/packages,

* Armedillo, http://arma.sourceforge.net/
* boost, https://www.boost.org/
* eigen, http://eigen.tuxfamily.org
* GNU Octave, https://www.gnu.org/software/octave/
* GSL, https://www.gnu.org/software/gsl/
* LAPACK, http://www.netlib.org/lapack/
* MKL, https://software.intel.com/en-us/mkl
* Maple, https://www.maplesoft.com/
* Mathematica, https://www.wolfram.com/mathematica/
* MATLAB, https://www.mathworks.com/
* SageMath, http://www.sagemath.org/
* Stata, https://www.stata.com/
* SAS, https://www.sas.com/
* R, https://www.r-project.org/
* Stan, http://mc-stan.org/
* BUGS, https://www.mrc-bsu.cam.ac.uk/software/bugs/
* JAGS, http://mcmc-jags.sourceforge.net/
* OpenBUGS, www.openbugs.net/
* Visual Studio Code, https://code.visualstudio.com/

which serve as backbone for a variety of projects including those in genetics. Illustration is given for some under Ubutun except R-devel which is with Fedora whose C/C++ version is higher,

## --- Armadillo ---

It is available with
```bash
sudo apt install libarmadillo-dev
```

## --- boost ---

It is installed with
```bash
sudo apt install libboost-all-dev
```
## --- eigen ---

It is installed with
```bash
sudo apt install libeigen3-dev
```
## --- GSL ---

```bash
sudo apt install libgsl-dev
```

## --- JAGS-4.3.0 ---

These are required at least under Federa 28,
```bash
sudo dnf install automake
sudo dnf install lapack-devel
sudo dnf install mercurial
```
It is actually available from Ubuntu archive, i.e.,
```bash
sudo apt install jags
sudo apt-get install r-cran-rjags
```
We can also work with sourceforge,
```bash
wget https://sourceforge.net/projects/mcmc-jags/files/JAGS/4.x/Source/JAGS-4.3.0.tar.gz
tar xvfz JAGS-4.3.0.tar.gz
cd JAGS-4.3.0
./configure --prefix=/scratch/jhz22 --with-lapack=/scratch/jhz22/lib64/liblapack.so --with-blas=/scratch/jhz22/lib64/libblas.so
make
make install
```

## --- BLAS and LAPACK ---

THe pre-built version is straightforward,
```bash
sudo apt install libblas-dev
sudo apt install liblapack-dev
```
To install from http://www.netlib.org/lapack/, we proceed as follows,
```bash
wget http://www.netlib.org/lapack/lapack-3.8.0.tar.gz
tar xvfz lapack-3.8.0.tar.gz
cd lapack-3.8.0
mkdir build
## ccmake .
cmake ..
make
make install
```
It is necessary to invoke `ccmake ..` to change the default static to dyanmic library as well as target directory.

## --- MKL ---

It is conviently available from Anaconda,
```bash
conda install -c intel mkl
```
Example use with R under RHEL,
```bash
# export OMP_NUM_THREADS=6
export MKL_NUM_THREADS=15
export MKLROOT=/genetics/data/software/intel/composer_xe_2013.4.183/mkl
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MKLROOT/lib/intel64
/genetics/data/software/intel/composer_xe_2013.4.183/mkl/bin/mklvars.sh intel64
./configure --prefix=/genetics/data/software --enable-R-shlib --enable-threads=posix --with-lapack \
 --with-blas="-fopenmp -m64 -I$MKLROOT/include -L$MKLROOT/lib/intel64 -lmkl_gf_lp64 -lmkl_gnu_thread -lmkl_core -lpthread -lm"
make
make install
```

## --- GNU Octave ---

It is available with,
```bash
sudo apt install octave
```

## --- R ---

### Fedora 28

The R-release is built as follows,
```bash
sudo dnf install R
sudo dnf install R-devel
```
The following are necessary to build [R-devel](https://stat.ethz.ch/R/daily/R-devel.tar.gz),
```bash
sudo dnf install gcc-c++
sudo dnf install gcc-gfortran
sudo dnf install compat-gcc-34-g77
sudo dnf install java-openjdk-devel
sudo dnf install pcre-devel
sudo dnf install readline-devel
sudo dnf install libcurl-devel
sudo dnf install libX11 libX11-devel libXt libXt-devel
sudo dnf install bzip2-devel
sudo dnf install xz-devel
sudo dnf install texlive-collection-latex
sudo dnf install texlive-collection-fontsextra
sudo dnf install texinfo-tex
sudo dnf install texlive-collection-fontsrecommended
sudo dnf install texlive-collection-latexrecommended
./configure
```
This is necessary since gcc 8 is available and required for [CRAN package submission](https://cran.r-project.org/submit.html), e.g.,
```bash
# R-release to build
R CMD build gap
# R-devel to check
ln -s $HOME/R/R-devel/bin/R $HOME/bin/R-devel
R-devel CMD check --as-can gap_1.1-22.tar.gz
```
### Ubuntu 18.04

The R environment is furnished with
```{bash}
sudo apt install r-base-core
sudo apt install r-base-dev
```
and R_LIBS is set from .bashrc
```{bash}
export R_LIBS=/usr/local/lib/R/site-library/
```
Note that in fact `html.start()` in R points to /usr/local/lib/R/library/ instead, see below example in `MendelianRandomization`.

To enable R-devel/package building, these are necessary
```bash
sudo apt install g++
sudo apt install gfortran
sudo apt install texlive
sudo apt install texlive-fonts-extra
sudo apt install texinfo
sudo apt install texlive-fonts-recommended
sudo apt install libreadline-dev
```

### Windows

To build packages on Windows, download Rtools from https://cran.r-project.org/ and install to C:\Rtools
```dos
rem 29/8/2019 JHZ

set path=C:\Users\jhz22\R-3.5.1\bin;c:\Rtools\bin;%PATH%;c:\Rtools\mingw_64\bin;c:\Rtools\mingw_32\bin
set lib=c:\Rtools\mingw_64\lib;c:\Rtools\mingw_32\include
set include=c:\Rtools\mingw_64\include;c:\Rtools\mingw_32\include
```
We can then run `R CMD INSTALL --binary gap`, say.

It seems the --arch x84 option is very useful for using all available RAM; to make sure use call such as `D:\Program Files\R\R-3.5.0\bin\x64\R.exe"`.

When this fails, remove large objects in your code and start R with `--vanilla` option.

### Package installation

**CRAN**. It is typically done with `install.packages()`
```r
install.packages("ggplot2",INSTALL_opts="--library=/usr/local/lib/R/site-library/")
```
**Bioconductor**. This is done with `biocLite`.
```r
source("https://bioconductor.org/biocLite.R")
biocLite("packagename")
```
**GitHub**. This is through `devtools::install_github()`.
```r
library(devtools)
install_github("MRCIEU/TwoSampleMR",args="--library=/usr/local/lib/R/site-library",force=TRUE)
```
with dedicated location(s); however this is not always the case and an alternative is to use
```bash
sudo R CMD INSTALL <packed/unpacked package> -l $R_LIBS
```
to install into $R_LIBS.

It is possible to point to a package, locally or remotely, e.g,
```r
install.packages("http://cnsgenomics.com/software/gsmr/static/gsmr_1.0.6.tar.gz",repos=NULL,type="source")
```
whose first argument is a URL.

**Multiple precision arithmetic**. This is modified from notes on SCALLOP-INF analysis.

```bash
sudo apt install libmpfr-dev
R --no-save <<END
require("Rmpfr")
z <- 20000
Rmpfr::pnorm(-mpfr(z,100), mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
Rmpfr::pnorm(-mpfr(z,100), mean = 0, sd = 1, lower.tail = TRUE, log.p = TRUE)
# competitor
-log10(2)-pnorm(-z,lower.tail=TRUE,log.p=TRUE)/log(10)
END
```
The function `pnrom(-(abs(z), lower.tail=TRUE, log.p=TRUE)` in R is doing surprisingly well.

**`tidy.R`**. The following code formats R source codes according to the R session,
```bash
function tidy()
{
  export input=$1
R --vanilla <<END
  options(keep.source = FALSE)
  input <- Sys.getenv("input")
  source(input)
  dump(ls(all = TRUE), file = paste0(input,"_out"))
END
}
```

### RStudio

The distribution has problem loading or creating R script, so it is tempting to install from https://github.com/rstudio/rstudio/. 
This involves running scripts under directory dependencies/,
```{bash}
./install-dependencies-debian --exclude-qt-sdk
```
and then the following steps,
```{bash}
mkdir build
cd build
cmake .. -DRSTUDIO_TARGET=Desktop -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local/lib/rstudio
```
However, there is error with Java and Java 8 is required, see https://tecadmin.net/install-oracle-java-8-ubuntu-via-ppa/.
```{bash}
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java8-set-default
java -version
```
However, compile error is still persistent except when dropping the option `--exclude-qt-sdk` but unloadable.

It is therefore recommended to get around with RStudio daily builds, https://dailies.rstudio.com/.

## --- SageMath ---

```bash
sudo apt install sagemath
```

## --- stan ---

cmdstan is now available from https://github.com/stan-dev/cmdstan along with other repositories there. Interfaces are listed at http://mc-stan.org/users/interfaces/index.html.
