This is a skeleton to list items to be detailed in the near future.

## Contents

---

* [Ubuntu](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#ubuntu)
* [Oracle VirtualBox](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#oracle-virtualbox)
* [Windows Subsystem for Linux](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#WSL)
* [Anaconda](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#anaconda)
* [GitHub](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#github)
* [Mercurial](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#mercurial)
* [Linuxbrew](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#linuxbrew)
* [AWS](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#aws)
* [modules](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#modules)
* [docker](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#docker)
* [OpenVPN](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#openvpn)

---

There are multiple routes to install particular software; one may prefer to install them as standable but it may also come handy use mini-environments such as Anaconda, Miniconda, Linuxbrew or those already in system (e.g. Ubuntu) archive.

A rich source of tips are in [the-art-of-command-line](https://github.com/jlevy/the-art-of-command-line) and [awesome-shell](https://github.com/alebcay/awesome-shell).

The LSB (Linux Standard Base) and distribution information is given with
```bash
lsb_release -a
```
Under Fedora, you may be prompted to install package `redhat-lsb-core`. Related commands are `uname -a` and `lscpu`.

## Ubuntu

Releases are available from http://releases.ubuntu.com and packages are listed at https://packages.ubuntu.com/.

Non-root installation may be necessary, e.g.,
```bash
apt download gir1.2-webkit-3.0
apt -i gir1.2-webkit-3.0_2.4.11-3ubuntu3_amd64.deb --force-not-root --root=$HOME
```
Alternatively, we use source package, typically
```bash
apt-get source package
cd package
./configure --prefix=$HOME
make
make install
```
To unpack a package, one can do
```bash
dpkg -x package.deb dir
```
When a package URL is available, we can use wget, ar x, xz -d, tar xvf combination to do so.

Its archive, http://archive.ubuntu.com/ubuntu/pool/universe, includes beagle, eigensoft, plink, plink-1.9, among others, which can be installed canonically with ```sudo apt install```.

```bash
sudo apt-get install libcanberra-gtk3-module
```

## Oracle VirtualBox

The guest additions under Fedora 28 is furnished with
```bash
sudo dnf update
sudo dnf install gcc kernel-devel kernel-headers dkms make bzip2 perl
cd /run/media/jhz22/VBox_GAs_5.2.12/
sudo ./VBoxLinuxAdditions.run
```
To set up shared folders and enforce shared clipboard for bidirectional copy between Linux and Windows,
```bash
# shared folders
sudo mount -t vboxsf -o uid=jhz22 C /home/jhz22/C
sudo mount -t vboxsf -o uid=jhz22 D /home/jhz22/D
# shared clipboard
killall VBoxClient
sudo VBoxClient-all
```
Here are the steps, quoting http://www.netreliant.com/news/8/17/Compacting-VirtualBox-Disk-Images-Linux-Guests.html, for compressing large .vdi:
```bash
# Linux
dd if=/dev/zero of=zerofillfile bs=1M

rem Windows
path D:\Program Files\Oracle\VirtualBox
VBoxManage modifyhd --compact "ubuntu18.04.vdi"
```

[vdi.md](https://github.com/jinghuazhao/GDCT/blob/master/vdi.md) as in GWAS-2017 and now listed in [GDCT](https://github.com/jinghuazhao/GDCT)

Since one may allocate only part of RAM to VirtualBox, it is often necessary to run program under MS-DOS, e.g., sections on DEPICT.

## WSL

It is very easy to work with mobaXterm. When started, create a session for WSL which directs you to Windows Apps store. Obtain Ubutun, and install.
```bash
sudo apt update
sudo apt install nautilus
sudo apt install firefox
```
etc. By default C:\ is /mht/c. To establish other drives, one can do
```bash
sudo mkdir /mnt/d
sudo mount -t drvfs D: /mnt/d
sudo unmount /mnt/d
```
It is also possible to map network drive, it is sufficient to do so
```bash
sudo mkdir /mnt/u
sudo mount -t drvfs '\\me-filer1.medschl.cam.ac.uk\home$\jhz22' /mnt/u
```

## Anaconda

Once installed, it is customary to make several channels accessible,

```
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
```
Package in conda-forge include boost, django, glpk, gnuplot, go, gperf, hdf5, ipython, jquery, julia, jupyter, keras, limix, mercurial, miktex, mysql, nano, numpy, pandas, sage, scikit-learn, zlib. Packages in bioconda includes amos, bcftools, beagle, bedops, bedtools, blast, bowtie, bowtie2, bwa, chromhmm, circos, deeptools, emmix, ensembl-vep, fastlmm, fastqc, gatk, gatk4, hclust2, himmer, himmer2, hisat2, igv, impute2, lofreq, mapsplice, mrbayes, ms, nanostat, paml, pbgzip, phylip, picard, plink, plink2, r-wgcna, rsem, rtg-tools, sambamba, samtools, seqkt, sequana, snpeff, snpsift, sra-tools, star, stringtie, tabix, tophat, ucsc-blat, ucsc-liftover, vcftools.

For instance, to install `intervaltree` as required by depict, the following is sufficience,
```bash
conda install intervaltree
```
All the packages installed can be seen with `conda list`. To install java, run following command
```
conda install -c anaconda openjdk
```
Other installations include perl, R. Note that conda under Windows is in typically D:/ProgramData/Anaconda2/Library/bin. Altogether we really need to
```
set path=%path%;D:/ProgramData/Anaconda2;D:/ProgramData/Anaconda2/Library/bin
```
Miniconda is available from https://conda.io/miniconda.html. 

Installation from scratch,
```bash
wget https://repo.anaconda.com/archive/Anaconda2-2019.03-Linux-ppc64le.sh
sh Anaconda2-2019.03-Linux-ppc64le.sh
# do not activate at startup
conda config --set auto_activate_base false
export PYTHONPATH=/scratch/jhz22/lib/python2.7/site-packages/
```
Examine .bashrc for changes.

## GitHub

See [physalia](https://github.com/jinghuazhao/physalia) for information.

## mercurial

This is associated with the familiar `hg` command as used for instance by `qctool`.

It is the executable file for Mercurial source code management system,
```bash
sudo apt install mercurial
```

## Linuxbrew

Follow http://linuxbrew.sh/ and possibly https://docs.brew.sh
```bash
sudo apt-get install build-essential
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >>~/.profile
echo 'export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"' >>~/.profile
echo 'export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"' >>~/.profile
PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
```

## AWS

[The Open Guide to Amazon Web Services](https://github.com/open-guides/og-aws).

## modules

It is a system that allows you to easily change between different versions of compilers and other software.

```bash
function module ()
{
    curl -sf -XPOST http://modules-mon.hpc.cam.ac.uk/action -H 'Content-Type: application/json' -d '{ "username":"'$USER'", "hostname":"'$HOSTNAME'", "command":"'"$*"'" }' 2>&1 > /dev/null;
    eval `/usr/bin/modulecmd bash $*`
}

module load matlab/r2014a
matlab $@
```
Usually the `eval` line is sufficient.

## docker

See [https://www.docker.com/](https://www.docker.com/).

## OpenVPN

See [https://github.com/OpenVPN/openvpn-gui](https://github.com/OpenVPN/openvpn-gui).

Usage example:
```bash
sudo openvpn --config myconfig.vopn
```
