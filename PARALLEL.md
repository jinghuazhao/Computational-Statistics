# Parallel computing

# LIST

* GNU Parallel
* SGE
* SLURM

## GNU parallel

[GNU parallel](https://www.gnu.org/software/parallel/) is the most handy to use -- note with its --env to pass environment variables.

Under Ubuntu, GNU parallel is easily installed as follows,
```{bash}
sudo apt install parallel
```

## SGE

General information is [here](https://en.wikipedia.org/wiki/Oracle_Grid_Engine).

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
