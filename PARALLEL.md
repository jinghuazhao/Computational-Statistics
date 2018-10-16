# Parallel computing

# LIST

* GNU Parallel
* sge
* SLURM

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
