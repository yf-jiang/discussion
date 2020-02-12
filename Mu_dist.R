# module load R
# srun -p high2 -t 1 -n 4 Rscript Mu_dist.R

suppressPackageStartupMessages({
  library(pbdMPI)
})

init()
.comm.size <- comm.size()
.comm.rank <- comm.rank()

if (.comm.rank == 0) {
  # only the rank 0 needs the data
  library(purrr)
  x <- map(1:10000,~rnorm(100,mean = 3,sd = 2))
} else {
  x <- NULL
}

y <- pbdLapply(x, mean, pbd.mode = "mw")

comm.print(y)

### Finish.
finalize()