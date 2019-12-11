This is a skeleton to list items to be detailed in the near future.

## Contents

---

* [Ubuntu](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#ubuntu)
* [Oracle VirtualBox](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#oracle-virtualbox)
* [Windows Subsystem for Linux](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#WSL)
* [Anaconda](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#anaconda)
* [GitHub](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#github)
* [Mercurial](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#mercurial)
* [LibraOffice](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#libraoffice)
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
Under Ubuntu, this could be made available with `sudo apt-get install lsb-core`.

Under Fedora, you may be prompted to install package `redhat-lsb-core`. Related commands are `uname -a` and `lscpu`.

The CPU speed can be seen with 
```bash
 watch -n.1 "cat /proc/cpuinfo | grep \"^[c]pu MHz\""
```

## Ubuntu

Releases are available from http://releases.ubuntu.com and packages are listed at https://packages.ubuntu.com/.

Often it is helpful to run
```bash
sudo apt update
sudo apt upgrade
```
to be in line with the current release; one can check for updates with `sudo apt list --upgradable`.

The nautilus desktop can be reset with
```bash
sudo apt install gnome-tweak-tool
gnome-tweaks
nautilus-desktop
```

The Unity desktop can be installed with
```bash
sudo apt-get install unity-session
sudo dpkg-reconfigure lightdm
```

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
It is useful to use `sudo apt install tasksel`, then one can use `sudo tasksel`.


## Oracle VirtualBox

To use VirtualBox under Windows 7, one needs to enable virtualisation within security section of BIOS setup. To find out system info, one can run
```
systeminfo
```

A useful tip is from https://blog.csdn.net/xz360717118/article/details/67638548
```
Failed to instantiate CLSID_VirtualBox w/ IVirtualBox, but CLSID_VirtualBox w/ IUnknown works.
2017年03月28日 16:50:30 一只猪儿虫 阅读数 17551 标签： virtualbox win7 更多
个人分类： 服务器
版权声明：本文为博主原创文章，未经博主允许不得转载。 https://blog.csdn.net/xz360717118/article/details/67638548

我是 win7 64位

解决办法：

1， win+r 快捷键打开 “运行”，输入regedit 打开注册表


2，找到 HKEY_CLASSES_ROOT\CLSID\{00020420-0000-0000-C000-000000000046}
InprocServer32 修改 第一行（默认）的值为 C:\Windows\system32\oleaut32.dll


3，找到HKEY_CLASSES_ROOT\CLSID\{00020424-0000-0000-C000-000000000046}
InprocServer32  修改 第一行（默认）的值为 C:\Windows\system32\oleaut32.dll

4，完事。（我修改了完了 也没试用，直接重启电脑 然后成功了）
```
Actually, there is no need to reboot Windows at Step 4.

It is possible that installation of Ubuntu could be freezed, in which case a proposal was to proceed with disabling 3D Acceleration
and increasing the number of CPUs to 2-4, see [https://www.maketecheasier.com/fix-ubuntu-freezing-virtualbox/](https://www.maketecheasier.com/fix-ubuntu-freezing-virtualbox/).

However, our experiment showed that one can enable 3D Acceleration and two CPUs for installation but it is necessary to disable 3D Acceleration and 
reset CPU to be one for a system with one CPU after installation. The system informatino can be obtained with `systeminfo` command as described above.

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

A description on PowerShell is here, https://docs.microsoft.com/en-us/windows/wsl/install-win10.

After installation, it can be invoked from a MS-DOS prompt with
```
wsl
```
The command could also takes additional parameters.

It is very easy to work with mobaXterm. 

After started, create a session for WSL which directs you to Windows Apps store. Obtain Ubuntu, and install.
```bash
sudo apt update
sudo apt install nautilus
sudo apt install firefox
```
etc. By default C:\ is /mnt/c. To establish other drives, one can do
```bash
sudo mkdir /mnt/d
sudo mount -t drvfs D: /mnt/d
sudo umount /mnt/d
```
It is also possible to map network drive, e.g.,
```bash
sudo mkdir /mnt/u
sudo mount -t drvfs '\\me-filer1.medschl.cam.ac.uk\home$\jhz22' /mnt/u
```
See https://www.cyberciti.biz/faq/ubuntu-linux-install-gnome-desktop-on-server/. See also https://www.makeuseof.com/tag/linux-desktop-windows-subsystem/.

`ubuntu-wsl` is a set of WSL utilities, which could be installed with
```bash
sudo apt install ubuntu-wsl
```
for executables at `/usr/bin`, e.g., `wslvar PATH` for Windows' \%PATH environment variable and `wslsys` for basic information, `wslusc` to create a short cut on Windows desktop.

To install desktop via xrdp:

```bash
sudo apt update
sudo apt install xorg
sudo apt install xfce4
sudo apt install xrdp
sudo cp /etc/xrdp/xrdp.ini  /etc/xrdp/xrdp.ini.bak
# change to 3389 -> 3390
# sudo pico /etc/xrdp/xrdp.ini
sudo echo xfce4-session > ~/.xsession
sudo /etc/init.d/xrdp restart
# check for IPv4 address from Windows and start rdp to ip:3390
ipconfig
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

See [https://docs.anaconda.com/anaconda/user-guide/getting-started/](https://docs.anaconda.com/anaconda/user-guide/getting-started/) to get started.

## GitHub

See [physalia](https://github.com/jinghuazhao/physalia) for information.

## mercurial

This is associated with the familiar `hg` command as used for instance by `qctool`.

It is the executable file for Mercurial source code management system,
```bash
sudo apt install mercurial
```

## libraOffice

```bash
sudo add-apt-repository ppa:libreoffice/ppa
sudo apt-get update
sudo apt-get install libreoffice
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
