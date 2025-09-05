#PCA
module load R
module load plink/1.90b6.27
module load eigensoft

plink --bfile cleaned_samples/narac_hg19_filtered --extract narac_hg19_prune.prune.in --chr 1-22 --make-bed --out narac_hg19_pca_prune

smartpca -p narac_hg19_pca.par > narac_hg19_pca.out
#PC1 vs PC2
Rscript --vanilla plotPCs.R narac_hg19_pca.evec 1 2 10

awk '$2 < -0.01 && ($12 == "Control" || $12 == "Case") {print $0}' narac_hg19_pca.evec > pca_outliers.txt

Rscript evec_convert.R

