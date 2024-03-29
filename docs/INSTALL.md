# Installation notes

This section lists software which serve as backbone for a variety of projects including those in genetics.
Illustration is given for some under Ubutun except R-devel which is with Fedora whose C/C++ version is higher.

## Environment modules

Web: <https://modules.readthedocs.io/en/latest/>

It is preferable to allow for installation of multiple applications. The following scripts show how this is done under Ubunto.

```bash
wget http://archive.ubuntu.com/ubuntu/pool/universe/m/modules/modules_5.2.0.orig.tar.xz
tar xf modules_5.2.0.orig.tar.xz
cd modules-5.2.0
sudo apt-get install tcl-dev tk-dev
./configure
make
sudo make install
ls /usr/local/Modules
source /usr/local/Modules/init/bash
sudo ln -s /usr/local/Modules/init/profile.sh /etc/profile.d/modules.sh
sudo ln -s /usr/local/Modules/init/profile.csh /etc/profile.d/modules.csh
echo -e "\n# For initiating Modules" | sudo tee -a /etc/bash.bashrc > /dev/null  # Append a line to the end of this file with no return message.
echo ". /etc/profile.d/modules.sh" | sudo tee -a /etc/bash.bashrc > /dev/null
less /usr/local/Modules/init/profile.sh
module avail
module list
```

According to <https://www.microbialsystems.cn/en/post/xubuntu_env_modules/>. Instances at work is shown here, <https://cambridge-ceu.github.io/csd3/systems/ceuadmin.html>.

## Armadillo

It is available with
```bash
sudo apt install libarmadillo-dev
```

## boost

It is installed with
```bash
sudo apt install libboost-all-dev
```

To install it manually from source, as for a particular version, https://stackoverflow.com/questions/12578499/how-to-install-boost-on-ubuntu
```bash
wget https://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz
tar xvfz boost_1_58_0.tar.gz
cd boost_1_58_0
# ./b2 -h gives more options
./bootstrap.sh --prefix=/scratch/jhz22
./b2
```
With a successful built, the following directory is suggested to be added to compiler include paths:

    boost_1_58_0

The following directory should be added to linker library paths:

    boost_1_58_0/stage/lib

and we can test with example
```cpp
#include <iostream>
#include <boost/array.hpp>

using namespace std;
int main(){
  boost::array<int, 4> arr = {{1,2,3,4}};
  cout << "hi" << arr[0];
  return 0;
}
```

## eigen

It is installed with
```bash
sudo apt install libeigen3-dev
```
## GMP/MPFR

One can start usual from https://gmplib.org/ and https://www.mpfr.org/.
```bash
sudo apt install libgmp-dev
sudo apt install libmpfr-dev
```
then one can install Rmpfr. When installing as non-Admin, make sure issuing 'make check' for both libraries. As MPFR is dependent on GMP, it is necessary to use
```bash
cd /home/jhz22/Downloads/mpfr-4.0.1
./configure --prefix=/scratch/jhz22 --with-gmp-build=/home/jhz22/Downloads/gmp-6.1.2
make check
```
for instance.

## GSL

```bash
sudo apt install libgsl-dev
```

## JAGS-4.3.0

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
LDFLAGS="-L/scratch/jhz22/lib64" ./configure --prefix=/scratch/jhz22 --with-blas=-lblas --with-lapack=-llapack
make
make install
```
Under MKL, we have
```bash
#22-7-2014 MRC-Epid JHZ

export MKL_NUM_THREAD=15
export MKL=/home/jhz22/intel/composer_xe_2013.4.183/mkl
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MKLROOT/lib/intel64
/genetics/data/software/intel/composer_xe_2013.4.183/mkl/bin/mklvars.sh intel64
./configure --prefix=/home/jhz22 --disable-shared --with-lapack \
--with-blas="-fopenmp -m64 -I$MKL/include -L$MKL/lib/intel64 -lmkl_gf_lp64 -lmkl_gnu_thread -lmkl_core -lpthread -lm"
make
```
It turns out the easiest to install rjags package is to download it and work manually, e.g.,
```bash
R --no-save <<END
  download.packages("rjags",".",repos="https://cran.r-project.org")
END
tar xvfz rjags_4-8.tar.gz
cd rjags
rm configure
cd src
(
  echo CPP_FLAGS=-I/usr/local/include/JAGS
  echo LDFLAGS=-L/usr/local/lib
) > Makevars
cd ../..
R CMD INSTALL rjags
```
The rjags package can also be installed as follows,
```bash
export PKG_CONFIG_PATH=/scratch/jhz22/lib/pkgconfig

R CMD INSTALL rjags_4-6.tar.gz --configure-args='CPPFLAGS="-fPIC" LDFLAGS="-L/scratch/jhz22/lib -ljags"
--with-jags-prefix=/scratch/jhz22
--with-jags-libdir=/scratch/jhz22/lib
--with-jags-includedir=/scratch/jhz22/include'
```
It may still be difficult to install, and we can try manually,
```bash
tar xfz rjags_4-6.tar.gz
cd rjags
mv configure configure.bak
echo PKG_CPPFLAGS=-fPIC -I/scratch/$USER/include/JAGS > src/Makevars
echo PKG_LIBS=-L/scratch/$USER/lib -ljags >> src/Makevars
cd -
R CMD INSTALL rjags
```
After this, rjags should install as with R2jags.

We can also install JAGS-related packages by establishing an Makevars in the src directory, e.g.,
```bash
R --no-save <<END
download.packages("runjags",".")
END
tar xvfz runjags_2.0.4-2.tar.gz
cd runjags
mv configure configure.bak
# modify jagsversions.h
# cp Makevars.runjags src/Makevars
cd -
R CMD INSTALL runjags
```
We need to add modify runjags/src/jagsversions.h to proceed,
```c
#ifndef JAGS_VERSIONS_H_
#define JAGS_VERSIONS_H_

#include <version.h>
#ifndef JAGS_MAJOR
#define JAGS_MAJOR 4
#endif

#define JAGS_MAJOR_FORCED 0
```
where the Makevars.runjags has the following lines
```
PKG_CPPFLAGS=-I/scratch/jhz22/include
PKG_LIBS=-L/scratch/jhz22/lib -ljags 

OBJECTS= distributions/jags/DFunction.o distributions/jags/DPQFunction.o distributions/jags/PFunction.o distributions/jags/QFunction.o distributions/jags/RScalarDist.o distributions/DPar1.o distributions/DPar2.o distributions/DPar3.o distributions/DPar4.o distributions/DLomax.o distributions/DMouchel.o distributions/DGenPar.o distributions/DHalfCauchy.o runjags.o testrunjags.o
```
To get around these, one can mirror installation of rjags using the fact that runjags simply calls libjags.so though the source seemed for JAGS 3.x.x.,
```bash
export PKG_CONFIG_PATH=/rds-d4/user/jhz22/hpc-work/lib/pkgconfig
export LDFLAGS="-L/rds-d4/user/jhz22/hpc-work/lib -ljags -lblas -llapack"
R CMD INSTALL runjags_2.0.4-2.tar.gz --configure-args='
--with-jags-prefix=/rds-d4/user/jhz22/hpc-work
--with-jags-libdir=/rds-d4/user/jhz22/hpc-work/lib
--with-jags-includedir=/rds-d4/user/jhz22/hpc-work/include'
```
but somehow runjags is always points to lib64 for libjags.so, so when libjags.so is in lib instead it is necessary to create symbolic links from lib64.

## BLAS and LAPACK

The pre-built version is straightforward for Fedora with
```bash
sudo dnf install blas-devel
sudo dnf install lapack-devel
```
and the counterpart for Ubuntu is
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
cd build
## ccmake .
cmake ..
make
make install
```
It is necessary to invoke `ccmake ..` to change the default static to dyanmic library as well as target directory. However, in case this is working, one can proceed as follows,
```bash
cmake -DCMAKE_INSTALL_PREFIX=/rds-d4/user/jhz22/hpc-work -DCMAKE_BUILD_TYPE=RELEASE -DBUILD_SHARED_LIBS=ON -DCBLAS=ON -DLAPACKE=ON ..
make
make install
```

## MKL

One can consult [Intel® Math Kernel Library Link Line Advisor](https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor) and [Free access to Intel® Compilers, Performance libraries, Analysis tools and more...](https://software.intel.com/en-us/articles/free-ipsxe-tools-and-libraries).

For instance, it is conviently available from Anaconda,
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
and
```bash
# https://software.intel.com/en-us/articles/build-r-301-with-intel-c-compiler-and-intel-mkl-on-linux#
export ICC_OPT="-mkl -xHOST -fp-model strict"
export CC="icc $ICC_OPT"
export CXX="icpc $ICC_OPT"
export FC="ifort -mkl -xHOST"
export F77="ifort -mkl -xHOST"
export FPICFLAGS=" -fPIC"
export AR=xiar
export LD=xild
export MKL="-lmkl_gf_lp64 -lmkl_intel_thread  -lmkl_core -liomp5 -lpthread"
./configure --prefix=/home/jhz22/R-devel --enable-R-shlib --with-x=no --with-blas=-lmkl LDFLAGS=-L/home/jhz22/lib CPPFLAGS=-I/home/jhz22/include
```
For Windows, see https://software.intel.com/content/www/us/en/develop/documentation/get-started-with-mkl-for-windows/top.html. The benchmark is available from here, https://github.com/pachamaltese/r-with-intel-mkl/blob/master/00-benchmark-scripts/1-r-benchmark-25.R.
```dos
cd "C:\Program Files\R\R-4.0.0\bin\x64"
rename Rblas.dll Rblas.dll.orig
rename Rlapack.dll Rlapack.dll.orig
cd "C:\Program Files (x86)\IntelSWTools\compilers_and_libraries\windows\redist\intel64_win\mkl"
copy mkl_rt.dll "C:\Program Files\R\R-4.0.0\bin\x64\Rblas.dll"
copy mkl_rt.dll "C:\Program Files\R\R-4.0.0\bin\x64\Rlapack.dll"
copy mkl_intel_thread.dll "C:\Program Files\R\R-4.0.0\bin\x64"
```
making this known the PATH.

## NLopt

Available from https://nlopt.readthedocs.io/en/latest/ with R counterpart from https://cran.r-project.org/web/packages/nloptr/index.html.

## GNU Octave

It is available with,
```bash
sudo apt install octave
```

## PSPP

Under Ubuntu, this can be made available with
```bash
sudo apt install pspp
```

For Fedora, we have
```bash
sudo dnf install pspp
```
which will install libpq, gsl, gtksourceview3, spread-sheet-widget as well, see https://apps.fedoraproject.org/packages/pspp.

Two simple SPSS command files [example.sps](src/example.sps) and [plot.sps](src/plot.sps) can be called with
```bash
pspp example.sps 
psppire plot.sps
```
showing CLI and GUI, respectively. Related utilities are `pspp-convert`.

It is possible to compile it directly by using

* gtksourceview 4.0.3 (4.4.0 is more demanding with Python 3.5, meson, Vala, etc.) and use PKG_CONFIG_PATH when appropriate
* spread-sheet-widget-0.3
* fribidi-1.0.8
* GTKSOURVIEW_CFLAGS and GTKSOURVIEW_LIBS in the configuration.

```bash
export PREFIX=/rds/user/$USER/hpc-work
export GTKSOURCEVIEW_CFLAGS=-I${PREFIX}/includegtksourceview-4
export GTKSOURCEVIEW_LIBS="-L${PREFIX}/lib -lgtksourceview-4"
./configure --prefix=${PREFIX}
make
make install
```
note that it is necessary to comment on the statement `kludge = gtk_source_view_get_type ();` from `src/ui/gui/widgets.c`
and to remove the `PREFIX=` speficiation in the Perl part of compiling, i.e,
```
cd perl-module
/usr/bin/perl Makefile.PL PREFIX=/rds/user/$USER/hpc-work OPTIMIZE="-g -O2 -I/rds-d4/user/$USER/hpc-work/include/fribidi -I/usr/include/cairo -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng15 -I/usr/include/uuid -I/usr/include/libdrm -I/usr/include/pango-1.0 -I/usr/include/harfbuzz  "
```

A more recent description is here, [https://cambridge-ceu.github.io/csd3/applications/pspp.html](https://cambridge-ceu.github.io/csd3/applications/pspp.html).

## python

A useful resource is code from [Pattern Recognition and Machine Learning](https://github.com/ctgk/PRML).

It is possible to conduct survival analysis with [lifelines](https://lifelines.readthedocs.io/en/latest/index.html),
```bash
pip install lifelines
```
## R

### Fedora 31

The R-release, including both the compiled and source package, is built as follows,
```bash
sudo dnf install R
sudo dnf install R-devel
```
while the following are necessary to build [the development version](https://stat.ethz.ch/R/daily/R-devel.tar.gz),
```bash
sudo dnf install gcc-c++
sudo dnf install gcc-gfortran
sudo dnf install pcre-devel
sudo dnf install java-1.8.0-openjdk-devel
sudo dnf install readline-devel
sudo dnf install libcurl-devel
sudo dnf install libX11-devel
sudo dnf install libXt-devel
sudo dnf install bzip2-devel
sudo dnf install xz-devel
sudo dnf install pandoc
sudo dnf install qpdf
sudo dnf install texlive-collection-latex
sudo dnf install texlive-collection-fontsextra
sudo dnf install texinfo-tex
sudo dnf install texlive-collection-fontsrecommended
sudo dnf install texlive-collection-latexrecommended
./configure
```
This is necessary since gcc 9 is available and required for [CRAN package submission](https://cran.r-project.org/submit.html), e.g.,
```bash
# R-release to build
R CMD build gap
# R-devel to check
ln -s $HOME/R/R-devel/bin/R $HOME/bin/R-devel
R-devel CMD check --as-cran gap_1.1-22.tar.gz
```

For R-devel, these can be used explicitly,
```bash
export CC="/usr/bin/gcc"
export CXX="/usr/bin/g++"
export FC="/usr/bin/gfortran"
export CFLAGS="-g -O2 -Wall -pedantic -mtune=native"
export FFLAGS="-g -O2 -mtune=native -Wall -pedantic"
export CXXFLAGS="-g -O2 -Wall -pedantic -mtune=native -Wno-ignored-attributes -Wno-deprecated-declarations -Wno-parentheses"
export LDFLAGS="-L/usr/lib64"
R-devel CMD INSTALL gap_1.2.tar.gz
```
with check on foreign language calls or
```bash
R-devel CMD INSTALL --configure-args="
 CC=\"/usr/bin/gcc\" \
 CXX=\"/usr/bin/g++\" \
 FC=\"/usr/bin/gfortran\" \
 CFLAGS=\"-g -O2 -Wall -pedantic -mtune=native\" \
 FFLAGS=\"-g -O2 -mtune=native -Wall -pedantic\" \
 CXXFLAGS=\"-I/usr/include -g -O2 -Wall -pedantic -mtune=native -Wno-ignored-attributes -Wno-deprecated-declarations -Wno-parentheses\" \
 LDFLAGS=\"-L/usr/lib64\" gap_1.1-26.tar.gz
 ```
which is more restrictive than the default --as-cran above. A simpler setup is also possible with `~/.R/Makevars`, e.g.,
```bash
CC = gcc
CXX = g++
CXX11 = g++
FC = gfortran
F77 = gfortran
F90 = gfortran
CFLAGS = -std=c99 -I/usr/include -g -O2 -Wall -pedantic -mtune=native -Wno-ignored-attributes -Wno-deprecated-declarations -Wno-parentheses -Wimplicit-function-declaration
CXXFLAGS = -std=c++11
```
Another example is as follows,
```bash
module load texlive
./configure --prefix=/rds-d4/user/jhz22/hpc-work \
            --enable-R-shlib \
            CPPFLAGS=-I/rds-d4/user/jhz22/hpc-work/include \
            LDFLAGS=-L/rds-d4/user/jhz22/hpc-work/lib
```

On Fedora 35, we see the following messages from `R CMD check gap_1.2.3-6.tar.gz`,

```
Error(s) in re-building vignettes:
  ...
--- re-building ‘gap.Rmd’ using rmarkdown
Quitting from lines 273-279 (gap.Rmd)
Error: processing vignette 'gap.Rmd' failed with diagnostics:
X11 font -adobe-helvetica-%s-%s-*-*-%d-*-*-*-*-*-*-*, face 1 at size 5 could not be loaded
--- failed re-building ‘gap.Rmd’
--- re-building ‘shinygap.Rmd’ using rmarkdown
--- finished re-building ‘shinygap.Rmd’
--- re-building ‘jss.Rnw’ using Sweave
--- finished re-building ‘jss.Rnw’

SUMMARY: processing the following file failed:

  ‘gap.Rmd’

Error: Vignette re-building failed.
Execution halted

* checking PDF version of manual ... OK
* checking HTML version of manual ... NOTE
Skipping checking HTML validation: no command 'tidy' found
Skipping checking math rendering: package 'V8' unavailable
* checking for non-standard things in the check directory ... OK
* checking for detritus in the temp directory ... OK
* DONE

```

This is resolved by

```bash
sudo dnf install v8-devel
sudo dnf install xorg-x11-fonts*
Rscript -e 'install.packages(c("shniy","V8"),repos="https://cran.r-project.org")'
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
To set up bzip2, lzma/pcre, curl and then R assuming lapack is already installed,
```bash
# compile shared library Makefile-libbz2_so and then add -FPIC to CC and recompile
# bzip2
# make
# make install PREFIX=$SHOME

# xz
# ./configure --prefix=SHOME/xz-5.2.3
# make -j3
# make install

# pcre
# ./configure  --prefix=$SHOME  --enable-utf8

# curl
# ./configure  --prefix=$SHOME --with-ssl
# make && make install
./configure --prefix=/scratch/jhz22 --enable-R-shlib CPPFLAGS="-I/scratch/jhz22/include" LDFLAGS="-L/scratch/jhz22/lib"

```

### Windows

To build packages on Windows, download Rtools from https://cran.r-project.org/ and install to C:\Rtools
```dos
rem 22/8/2019 JHZ

set path=C:\Program Files\R\R-3.6.1\bin;c:\Rtools\bin;%PATH%;c:\Rtools\mingw_64\bin;c:\Rtools\mingw_32\bin
set lib=c:\Rtools\mingw_64\lib;c:\Rtools\mingw_32\include
set include=c:\Rtools\mingw_64\include;c:\Rtools\mingw_32\include
```
We can then run `R CMD INSTALL --binary gap`, say.

It seems the --arch x84 option is very useful for using all available RAM; to make sure use call such as `D:\Program Files\R\R-3.5.0\bin\x64\R.exe"`.

When this fails, remove large objects in your code and start R with `--vanilla` option.

To upgrade R, it is useful to install `installr` for its `updateR()`.

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
From R 3.5 or greater there is BiocManager,
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install()
```
See https://bioconductor.org/install/.

Lastly, it is possible with `devtools::install_bioc()`.

**GitHub**. We could set this up via `sudo apt install r-cran-devtools`. This is then through `devtools::install_github()`.
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
The function `pnorm(-abs(z), lower.tail=TRUE, log.p=TRUE)` in R is doing surprisingly well and now an R/gap utility function.

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

**Package reinstallation**

For instance to replace packages under gcc 4.4.7 to gcc 5.4.0, one can resinstall all packages as in /scratch/jhz22/R to /home/jhz22/R,
```bash
R --no-save <<END
from <- "/scratch/jhz22/R"
to <- "/home/jhz22/R"
pkgs <- unname(installed.packages(lib.loc = from)[, "Package"])
pkgs
install.packages(pkgs, lib=to, repos="https://cran.r-project.org")
END
```

**Mirror**

We can mirror R packages from $HOME to /scratch as follows,
```bash
rsync -avrzP /home/$USER/R /scratch/$USER/R
```

**Reinstallation**

This could be done with
```r
update.packages(checkBuilt = TRUE, ask = FALSE)	
```

**Specification of repository**

One may see error message on package installation
```
> install.packages("plotly")

--- Please select a CRAN mirror for use in this session ---

Error in structure(.External(.C_dotTclObjv, objv), class = "tclObj") : 

  [tcl] bad pad value "2m": must be positive screen distance.
```
but can be avoided with specificatino of repository.
```r
> install.packages("plotly", repos="https://cran.r-project.org")
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

## SageMath

```bash
sudo apt install sagemath
```

## stan

cmdstan is now available from https://github.com/stan-dev/cmdstan along with other repositories there. Interfaces are listed at http://mc-stan.org/users/interfaces/index.html.

Information on installing RStan is described here,

https://github.com/stan-dev/rstan/wiki/Installing-RStan-on-Linux

On our HPC system under gcc 4.8.5 there are error message
```
> library(rstan)
Loading required package: ggplot2
Registered S3 methods overwritten by 'ggplot2':
  method         from
  [.quosures     rlang
  c.quosures     rlang
  print.quosures rlang
Loading required package: StanHeaders
Error: package or namespace load failed for ‘rstan’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/rds-d4/user/jhz22/hpc-work/R/rstan/libs/rstan.so':
  /usr/lib64/libstdc++.so.6: version `GLIBCXX_3.4.20' not found (required by /rds-d4/user/jhz22/hpc-work/R/rstan/libs/rstan.so)
> q()

```
which can be resolved with `module load gcc/5.2.0` before invoking R.

For error message `C++14 standard requested but CXX14 is not defined` we modify $HOME/.R/Makevars as follows,
```
CXX14 = g++ -std=c++1y -fPIC
```
see [https://github.com/stan-dev/rstan/issues/569](https://github.com/stan-dev/rstan/issues/569) but adding -fPIC and as in unixOBD below.

## unixODBC

It is quite standard to install, i.e.,
```bash
wget ftp://ftp.unixodbc.org/pub/unixODBC/unixODBC-2.3.7.tar.gz
tar xvfz unixODBC-2.3.7.tar.gz
cd unixODBC-2.3.7
./configure --prefix=/scratch/jhz22
make
make install
```
There have been many discussions regarding "C++11 standard requested but CXX11 is not defined" and this could be fixed with changes to
$R_HOME/etc/Makeconf such that 
```
CXX11 = g++ -std=c++11 -fPIC
```
then

```bash
module load gcc/5.2.0
R CMD INSTALL odbc
```
This is necessary for `gtx` for instance. 

## zlib

Try
```bash
sudo apt-get install libz-dev
```
