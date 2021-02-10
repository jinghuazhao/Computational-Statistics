This is a skeleton to list items to be detailed in the near future.

## Contents

---

* [FreeDOS and Linux](https://github.com/jinghuazhao/Computational-Statistics/blob/master/SYSTEMS.md#freedos-and-linux)
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

## FreeDOS and Linux

FreeDOS is available from http://www.freedos.org/. 

> FreeDOS is an open source DOS-compatible operating system that you can use to play classic DOS games, run legacy business software, or develop embedded systems. Any program that works on MS-DOS should also run on FreeDOS.

It is notable that v1.3 provides liveCD and liteUSB which could be useful.

Here describes how to convert VMDK format to iso, https://www.ilovefreesoftware.com/26/featured/how-to-convert-vmdk-to-iso-in-windows.html, e.g.,
```dos
qemu-img convert -f vmdk FD13LITE.VMDK pd.raw
dd if=pd.raw of=pd.iso
```
We can then use rufus, https://rufus.ie/, to generate a bootable USB allowing for disk partition by `fdisk` -- in fact rufus itself can produce a bootable USB nevertheless with no utilities.

This is useful to install Linux on very old computers, e.g., reorganise hard drive and then install Fedora from a liveUSB generated from Fedora Media Writer, https://getfedora.org/en/workstation/download/.

There are multiple routes to install particular Linux software; one may prefer to install them as standable but it may also come handy use mini-environments such as Anaconda, Miniconda, Linuxbrew or those already in system (e.g. Ubuntu) archive.

A rich source of tips are in [the-art-of-command-line](https://github.com/jlevy/the-art-of-command-line) and [awesome-shell](https://github.com/alebcay/awesome-shell).

The following command gives bit information (32 or 64)
```bash
getconf LONG_BIT
```

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
The screen utility is operated as follows,
```bash
screen -S <my-screen-session>
screen -ls
screen -r <my-screen-session-id>
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

One would get error message such as "You must put some ‘source’ URIs in your sources.list" which can be done as follows
```bash
sudo apt-get update
sudo nano /etc/apt/sources.list
# uncomment deb-src here
apt-get source hello
```
To enable color with nano, try
```bash
find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; >> ~/.nanorc
```
The system hibernation can be done with `sudo systemctl hibernate`.


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

For Fedora 31, see https://www.if-not-true-then-false.com/2010/install-virtualbox-guest-additions-on-fedora-centos-red-hat-rhel/.

See https://www.nakivo.com/blog/make-virtualbox-full-screen/ on full-screen size, in particular,
```dos
"\Program Files\Oracle\VirtualBox\VBoxManage" setextradata "32" VBoxInternal2/EfiGraphicsResolution 1920x1080 for virtual machine 32.
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

Additional note: 6.1.4 has problem with its Guess Additions. To enable copy/paste through clipboard one can use [VBoxGuestAdditions_6.1.97-136310.iso](https://www.virtualbox.org/download/testcase/VBoxGuestAdditions_6.1.97-136310.iso) as discused here, https://www.virtualbox.org/ticket/19336.

## WSL

Official page: https://github.com/microsoft/WSL

A description on PowerShell is here, https://docs.microsoft.com/en-us/windows/wsl/install-win10. To initiate from PowerShell, use
```
dism /online /enable-feature /feature-name:Microsoft-Windows-Subsystem-Linux /all /norestart
```

After installation, it can be invoked from a MS-DOS prompt with
```
wsl -help
```
The command could also takes additional parameters, e.g., -d debian. Alternatively, one can create a desktop entry pointing to C:\Windows\system32\wsl.exe.

It is easy to work with mobaXterm, https://mobaxterm.mobatek.net/. At its`Advanced WSL settings` tab, choose `Graphical environments`
such as Gnome-desktop/LDXE-desktop/XFCE4-desktop so as to create sessions using graphical desktops. The corresponding installations
are `ubuntu-gnome-desktop` (gnome-session-bin), `lubuntu-desktop`, `xubuntu-desktop` (in fact xfce4-session, xubuntu-core, xubuntu-default-settings), respectively.

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

xfce4 can also be made available with
```bash
sudo apt update
sudo apt install xorg
sudo apt install xfce4
echo xfce4-session > ~/.xsession
xfce4-session &
```

or work with xrdp:
```bash
sudo apt install xrdp
sudo cp /etc/xrdp/xrdp.ini /etc/xrdp/xrdp.ini.bak
sudo sed -i 's/port=3389/port=3390/' /etc/xrdp/xrdp.ini
sudo /etc/init.d/xrdp restart
```
Now check IPv4 address from Windows with,
```windows
ipconfig.exe
```
and start and start rdp to \<IPv4 address\>:3390.

It might be hard to get going with firefox or Chrome for the Internet, but here is a simple way around,
```wsl
cmd.exe /c start https://github.com
echo cmd.exe /c start https://github.com > ${HOME}/bin/edge
chmod +x ${HOME}/bin/edge
edge
```
In fact, it is easy with default applications under Windows, e.g., `cmd.exe /c u:/work/eQTL-MR.pptx` which opens up PowerPoint directly.

One can actually generalise these, e.g., 
```wsl
ln -s $HOME/C/Program\ Files\ \(x86\)/Adobe/Acrobat\ Reader\ DC/Reader/AcroRd32.exe /home/$USER/bin/AcroRd32.exe
ln -s $HOME/bin/AcroRd32.exe /home/$USER/bin/xpdf
```
followed by a call to `AcroRd32.exe` and as `xpdf`, or directly call a list of programs: `calc.exe`, `comp.exe`, `control.exe`,
`curl.exe`, `fc.exe`, `find.exe`, `finger.exe`, `mspaint.exe`, `net.exe`, `sort.exe`, `tar.exe`, `whoami.exe`, `write.exe`, `xcopy.exe`.

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

It has been suggested to display math using the following premium in a GitHub page,

```
<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
<script type="text/javascript" id="MathJax-script" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/3.0.0/es5/latest?tex-mml-chtml.js">
</script>
<script>window.MathJax = {
  tex: {
    inlineMath: [['$', '$'], ['\\(', '\\)']]
  }
}
</script>
```

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

http://aws.amazon.com/

[The Open Guide to Amazon Web Services](https://github.com/open-guides/og-aws).

E.g.,

* https://sites.google.com/site/jpopgen/wgsa/create-an-aws-account
* https://sites.google.com/site/jpopgen/wgsa/launch-an-instance
* https://sites.google.com/site/jpopgen/wgsa/terminate-an-instance

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

See [https://www.docker.com/](https://www.docker.com/) and https://docs.docker.com/.

For Fedora 33, we have
```bash
udo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo docker pull eqtlcatalogue/susie-finemapping:v20.08.1
sudo docker run eqtlcatalogue/susie-finemapping:v20.08.1
# remove docker engine
# sudo dnf remove docker-ce docker-ce-cli containerd.io
# removed all images, containers, and volumes
sudo rm -rf /var/lib/docker
```

## OpenVPN

See [https://github.com/OpenVPN/openvpn-gui](https://github.com/OpenVPN/openvpn-gui).

Usage example:
```bash
sudo openvpn --config myconfig.vopn
```
