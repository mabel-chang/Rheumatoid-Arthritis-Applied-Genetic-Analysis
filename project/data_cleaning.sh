#DATA CLEANING
module load plink/1.90b6.27

#how many variants and individuals you start with
#544276 variants
wc -l samples/narac_hg19.bim
#2062 individuals
wc -l samples/narac_hg19.fam

#FILTER DATA
# individuals (missing genotypes) (>0.05)
# SNPs (missing genotypes) (>0.05)
# HWE (p<0.000001)
# MAF (<0.01)
plink --bfile samples/narac_hg19 --maf 0.01 --geno 0.05 --mind 0.05 --hwe 1e-6 --make-bed --out narac_hg19_filtered --allow-no-sex
#544276 variants loaded from .bim file.
#2062 people (569 males, 1493 females) loaded from .fam.
#2062 phenotype values loaded from .fam.
#0 people removed due to missing genotype data (--mind).
#Before main variant filters, 2062 founders and 0 nonfounders present.
#Total genotyping rate is 0.99269.
#18402 variants removed due to missing genotype data (--geno).
#--hwe: 663 variants removed due to Hardy-Weinberg exact test.
#22907 variants removed due to minor allele threshold(s) (--maf)
#502304 variants and 2062 people pass filters and QC.
#Among remaining phenotypes, 868 are cases and 1194 are controls.

#DIFFERENTIAL MISSINGNESS BY CASE STATUS
plink --bfile narac_hg19_filtered --test-missing --allow-no-sex --out ccnarac_hg19_filtered
awk '$5<0.0001{print $0}' ccnarac_hg19_filtered.missing > cc0001narac_hg19_filtered.txt
#6503 SNPs are significant at p<0.0001
wc -l cc0001narac_hg19_filtered.txt
sort -gk 5 cc0001narac_hg19_filtered.txt|head

#HETEROZYGOSITY: PAIRWISE LD PRUNING
# 10000kb window size
# 1 variant shift
# maximum r2=0.2
# remove pruned variants
plink --bfile narac_hg19_filtered --indep-pairwise 10000kb 1 0.2 --out narac_hg19_prune
#107710 variants remain after prune
wc -l narac_hg19_prune.prune.in

#PAIRWISE IBD ESTIMATES chromosomes 1-22
plink --bfile narac_hg19_filtered --chr 1-22 --extract narac_hg19_prune.prune.in --genome --out narac_hg19_ibd

awk '$10 > 0.25{print $0}' narac_hg19_ibd.genome>narac_hg19_ibd25.txt
# 2124891 variants remain (133 chromosome X variants were removed from the set
# 385255 variants and 2062 people pass filters and QC.
wc -l narac_hg19_ibd.genome
# 0 pairs share more than 25%
wc -l narac_hg19_ibd25.txt
