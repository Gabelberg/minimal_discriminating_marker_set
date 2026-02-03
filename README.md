# Minimal discriminating marker set finder

## Description
This repository contains R code to perform a simple analysis aimed at identifying, within a collection of sample genotypes, the smallest possible set of markers capable of discriminating all samples.  
The functions randomly order all markers and iteratively select the minimum subset required to discriminate all samples. This procedure is repeated multiple times; whenever a newly identified marker set is smaller than the one previously stored, it replaces it. A parallelization function allows the analysis to be run multiple times simultaneously across different processors.  
The output is a list of lists, each containing two elements: n_loci, the number of markers in the set, and loci, the names of the markers included in that set.

Markers can be of various types (e.g. microsatellites or SNPs) and may have more than two alleles per locus. The only requirement is the absence of missing values (NAs).  
The input is an object in the genind format from the R package adegenet.   
To run the functions, only the packages adegenet, poppr, and parallel are required; all are available on CRAN. For portability, a renv.lock file is also provided in this folder.

## Requirements
- R >= 4.2
- renv

or in alternative

- R >= 4.2
- adgenet
- poppr
- parallel


## Installation
```r
install.packages("renv")
renv::restore()
```

## Usage
In the R folder there are three R files:

*genotype_miniset.r* contains the function that performs marker permutation and selects the best discriminating marker set.  
*genotype_miniset_parallel.r* contains a function that enables multiple independent runs of the previous function and stores the results in a list. This is useful for comparing multiple possible minimal marker sets. Moreover, the function allows different runs to be executed on different threads.  
*analysis.r* contains the main script used to launch the analysis, including a public test dataset from the package adegenet.


## Licence
GNU General Public License v3.0

## Citation
Betto A, Scariolo F, Gabelli G, Riommi D, Farinati S, Vannozzi A, Palumbo F, Barcaccia G. ddRADseq Applications for Petunia × hybrida Clonal Line Breeding: Genotyping and Variant Identification for Target-Specific Assays. Horticulturae. 2026; 12(2):160. https://doi.org/10.3390/horticulturae12020160
