# Parallel computing

# LIST

* GNU Parallel
* SGE
* SLURM

## GNU parallel

It has home https://www.gnu.org/software/parallel/ -- note especially with its --env to pass environment variables.

Under Ubuntu, GNU parallel is easily installed as follows,
```{bash}
sudo apt install parallel
```
Earlier version had issues with temporary direvtory, e.g., https://stackoverflow.com/questions/24398941/gnu-parallel-unlink-error
if 
```bash
module load parallel/20131222
```
The lastest, http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2, can be used instead.

## SGE

Sun Grid Engine has a [wiki entry](https://en.wikipedia.org/wiki/Oracle_Grid_Engine).

https://peteris.rocks/blog/sun-grid-engine-installation-on-ubuntu-server/.

To delete SGE jobs shown in qstat, use 
```bash
qstat | grep $USER | cut -d" " -f1 | xargs qdel
```
Otherwise for a consecutive sequence we use qdel {id1..id2}.

## SLURM

General information is available from https://slurm.schedmd.com/.

A list of commands and their descriptions, http://www.arc.ox.ac.uk/content/slurm-job-scheduler

command | description
--------|-------------
sacct 	| report job accounting information about active or completed jobs
salloc 	| allocate resources for a job in real time (typically used to allocate resources and spawn a shell, in which the srun command is used to launch parallel tasks)
sbatch 	| submit a job script for later execution (the script typically contains one or more srun commands to launch parallel tasks)
scancel | cancel a pending or running job
scontrol| hold, holdu, release, requeue, requeuehold, suspend and resume commands
sinfo 	| reports the state of partitions and nodes managed by Slurm (it has a variety of filtering, sorting, and formatting options)
squeue 	| reports the state of jobs (it has a variety of filtering, sorting, and formatting options), by default, reports the running jobs in priority order followed by the pending jobs in priority order
srun 	| used to submit a job for execution in real time

e.g., squeue -u $USER -r; qstat -u $USER; also scontrol show config; scontrol show partition; scontrol show job [jobid] and sview

* job array, https://slurm.schedmd.com/job_array.html
* dependency, https://hpc.nih.gov/docs/job_dependencies.html
* examples, https://github.com/statgen/SLURM-examples
* temporary directories, https://help.rc.ufl.edu/doc/Temporary_Directories

> When a SLURM job starts, the scheduler creates a temporary directory for the job on the compute node's local hard drive. This $SLURM_TMPDIR directory is very useful for jobs that need to use or generate a large number of small files, as the /ufrc parallel filesystem is optimized for large file streaming and is less suitable for small files.

> The directory is owned by the user running the job. The path to the temporary directory is made available as the $SLURM_TMPDIR variable. At the end of the job, the temporary directory is automatically removed.

> You can use the ${SLURM_TMPDIR} variable in job scripts to copy temporary data to the temporary job directory. If necessary, it can also be used as argument for applications that accept a temporary directory argument.

> Many applications and programming languages use the $TMPDIR environment variable, if available, as the default temporary directory path. If this variable is not set, the applications will default to using the /tmp directory, which is not desirable. SLURM will set $TMPDIR to the same value as $SLURM_TMPDIR unless $TMPDIR has already been set, in which case it will be ignored. Check your job script(s) and shell initialization files like .bashrc and .bash_profile to make sure you do not have $TMPDIR set.

> If a personal Singularity container is used, make sure that the $SINGULARITYENV_TMPDIR variable is set within the job to export the local scratch location into the Singularity container. 

Examples of an interactive session can be simply `sintr`, or
```bash
srun -N1 -n1 -c1 -p long -t 1-2:0:0 --pty bash -i
```

## SGE to SLURM

Conversion is documented at https://srcc.stanford.edu/sge-slurm-conversion.
