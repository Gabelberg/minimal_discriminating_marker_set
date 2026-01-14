#### function to randomly select SNPs and to retain only the smaller set able to discriminate between all the genotypes.
genotype_minset <- function(
  gen,
  iter = 1000,
  drop = TRUE,
  dropna = TRUE,
  quiet = FALSE
) {

  if (!inherits(gen, c("genind", "genclone", "loci"))) {
    stop("gen must be a genind, genclone, or loci object")
  }

  # Convert to loci/genclone as in genotype_curve()
  if (inherits(gen, "loci")) {
    genloc <- gen
    gen <- pegas::loci2genind(gen)
  } else {
    genloc <- pegas::as.loci(gen)
  }

  if (!is.genclone(gen)) {
    gen <- as.genclone(gen)
  }

  the_loci <- attr(genloc, "locicol")
  res <- integer(nrow(genloc))
  genloc <- suppressWarnings(
    vapply(genloc[the_loci], as.integer, res)
  )

  # Drop monomorphic loci
  if (drop) {
    nas <- if (dropna) !is.na(genloc) else TRUE
    polymorphic <- colSums(!apply(genloc, 2, duplicated) & nas) > 1
    genloc <- genloc[, polymorphic, drop = FALSE]
  }

  n_ind <- nrow(genloc)
  loci_names <- colnames(genloc)
  n_loci <- ncol(genloc)

  best_set <- NULL
  best_size <- Inf

  for (i in seq_len(iter)) {

    loci_order <- sample(seq_len(n_loci))

    for (k in seq_along(loci_order)) {

      subset_idx <- loci_order[1:k]
      submat <- genloc[, subset_idx, drop = FALSE]

      # Count multilocus genotypes
      n_mlg <- nrow(unique(submat))

      if (n_mlg == n_ind) {

        if (k < best_size) {
          best_size <- k
          best_set <- loci_names[subset_idx]

          if (!quiet) {
            message(
              "New best set found at iteration ", i,
              " with ", k, " loci"
            )
          }
        }

        break
      }
    }
  }

  if (is.null(best_set)) {
    warning("No fully discriminating set found")
    return(NULL)
  }

  list(
    n_loci = best_size,
    loci = best_set
  )
}