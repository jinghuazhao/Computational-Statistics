# Parallel computing

# LIST

* GNU Parallel
* sge
* SLURM

## GNU parallel

Under Ubuntu, GNU parallel is easily installed as follows,
```{bash}
sudo apt install parallel
```

## sge

https://peteris.rocks/blog/sun-grid-engine-installation-on-ubuntu-server/.

To delete SGE jobs shown in qstat, use 
```bash
qstat | grep $USER | cut -d. -f1 | xargs qdel, qdel {id1..id2}
```

## SLURM

* SLURM documentation, https://slurm.schedmd.com/
* sinfo - view information about Slurm nodes and partitions
* squeue - view information about jobs located in the Slurm scheduling queue, squeue -u $USER -r; qstat -u $USER
* dependency, https://hpc.nih.gov/docs/job_dependencies.html
* examples, https://github.com/statgen/SLURM-examples.

SGE to SLURM conversion can be seen from https://srcc.stanford.edu/sge-slurm-conversion.

# modules

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
