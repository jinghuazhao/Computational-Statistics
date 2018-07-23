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

which serve as backbone for a variety of projects including those in genetics. Illustration is given for some under Ubutun except R-devel which is with Fedora whose C/C++ version is higher,

## boost and eigen

Under Ubuntu, they are insalled as follows,
```bash
sudo apt install libboost-all-dev
sudo apt install libeigen3-dev
```
## JAGS-4.3.0

These are required at least,
```bash
sudo dnf install automake
sudo dnf install lapack-devel
sudo dnf install mercurial
```

## BLAS and LAPACK

```bash
sudo apt install libblas-dev
sudo apt install liblapack-dev
```

## MKL

It is conviently available from Anaconda,
```bash
conda install -c intel mkl
```
A GNU-like software to MATLAB is octave,
```bash
sudo apt install octave
```

## R

It seems the --arch x84 option is very useful for using all available RAM; to make sure use call such as `D:\Program Files\R\R-3.5.0\bin\x64\R.exe"`.

When this fails, remove large objects in your code and start R with `--vanilla` option.

### Fedora 28

The guest additions is furnished with
```bash
sudo dnf install gcc kernel-devel kernel-headers dkms make bzip2 perl
cd /run/media/jhz22/VBox_GAs_5.2.12/
sudo ./VBoxLinuxAdditions.run
```
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
This is necessary since gcc 8 is available and required for CRAN package submission, e.g.,
```bash
# R-release to build
R CMD build gap
# R-devel to check
ln -s /home/jhz22/R/R-devel/bin/R /home/jhz22/bin/R-devel
R-devel CMD check --as-can gap_1.1-22.tar.gz
```
### UBUNTU 18.04

```{bash}
sudo apt install r-base-core
sudo apt install r-base-dev
```
and R_LIBS is set from .bashrc
```{bash}
export R_LIBS=/usr/local/lib/R/site-library/
```
Note that in fact `html.start()` in R points to /usr/local/lib/R/library/ instead, see below example in `MendelianRandomization`.

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

## sage

```bash
sudo apt install sagemath
```
