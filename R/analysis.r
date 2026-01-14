library(poppr)
library(adegenet)
library(parallel)

set.seed(1234)

source("genotype_miniset.r")
source("genotype_miniset_parallel.r")

data(nancycats)

res_list <- genotype_minset_parallel(
  gen = nancycats,       ### geneind object used as input .Package adegenet has an example geneind project called nancycats, to obatin it type data (nancycats).
  runs = 10,      ### time the function will run the search, to obtain different minimal set
  iter = 10,      ### number of permutation to compare in order to find a minimal set
  cores =  10     ### number of threads used by the function.
)

