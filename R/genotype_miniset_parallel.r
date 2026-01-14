
genotype_minset_parallel <- function(
  gen,
  runs = 50,
  iter = 2000,
  cores =  parallel::detectCores() - 1,
  quiet = TRUE
) {

  cores <- max(1, cores)

  cl <-  parallel::makeCluster(cores)
  on.exit(stopCluster(cl))

  # Load required packages on workers
   parallel::clusterEvalQ(cl, {
    library(poppr)
    library(pegas)
  })

  # Export function AND data
  parallel::clusterExport(
    cl,
    varlist = c("genotype_minset", "gen"),
    envir = environment()
  )

  # Reproducible RNG
  clusterSetRNGStream(cl, iseed = 123)

  res <- parallel::parLapply(
    cl,
    X = seq_len(runs),
    fun = function(i) {
      genotype_minset(
        gen = gen,
        iter = iter,
        quiet = quiet
      )
    }
  )

  # Drop failed runs
  res[!vapply(res, is.null, logical(1))]
}
