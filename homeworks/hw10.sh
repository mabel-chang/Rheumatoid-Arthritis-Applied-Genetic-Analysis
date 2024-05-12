#QUESTION 1
module load R
module load prsice

Rscript $SCC_PRSICE_BIN/PRSice.R --dir . \
    --prsice $SCC_PRSICE_BIN/PRSice \
    --base /projectnb/bs859/data/igap/Kunkle_etal_Stage1_results2019.txt.gz  \
    --target /projectnb/bs859/data/tgen/cleaned/TGEN_cleaned  \
    --stat Beta \
    --snp MarkerName \
    --A1 Effect_allele \
    --A2 Non_Effect_allele \
    --pvalue Pvalue \
    --binary-target T \
    --cov-file /projectnb/bs859/data/tgen/cleaned/TGEN_pcs.txt \
#    --extract 01_IGAP_base_TGEN_target.valid \
    --cov-col PC6,PC8 \
    --clump-kb 250 \
    --clump-r2 0.1 \
--out 01_IGAP_base_TGEN_target

Rscript $SCC_PRSICE_BIN/PRSice.R --dir . \
    --prsice $SCC_PRSICE_BIN/PRSice \
    --base /projectnb/bs859/data/igap/Kunkle_etal_Stage1_results2019.txt.gz  \
    --target /projectnb/bs859/data/tgen/cleaned/TGEN_cleaned  \
    --stat Beta \
    --snp MarkerName \
    --A1 Effect_allele \
    --A2 Non_Effect_allele \
    --pvalue Pvalue \
    --binary-target T \
    --cov-file /projectnb/bs859/data/tgen/cleaned/TGEN_pcs.txt \
#    --extract 05_IGAP_base_TGEN_target.valid \
    --cov-col PC6,PC8 \
    --clump-kb 250 \
    --clump-r2 0.5 \
--out 05_IGAP_base_TGEN_target

Rscript $SCC_PRSICE_BIN/PRSice.R --dir . \
    --prsice $SCC_PRSICE_BIN/PRSice \
    --base /projectnb/bs859/data/igap/Kunkle_etal_Stage1_results2019.txt.gz  \
    --target /projectnb/bs859/data/tgen/cleaned/TGEN_cleaned  \
    --stat Beta \
    --snp MarkerName \
    --A1 Effect_allele \
    --A2 Non_Effect_allele \
    --pvalue Pvalue \
    --binary-target T \
    --cov-file /projectnb/bs859/data/tgen/cleaned/TGEN_pcs.txt \
#    --extract 02_IGAP_base_TGEN_target.valid \
    --cov-col PC6,PC8 \
    --clump-kb 250 \
    --clump-r2 0.2 \
--out 02_IGAP_base_TGEN_target

#QUESTION 1c
Rscript $SCC_PRSICE_BIN/PRSice.R --dir . \
    --prsice $SCC_PRSICE_BIN/PRSice \
    --base /projectnb/bs859/data/igap/Kunkle_etal_Stage1_results2019.txt.gz  \
    --target /projectnb/bs859/data/tgen/cleaned/TGEN_cleaned  \
    --stat Beta \
    --snp MarkerName \
    --A1 Effect_allele \
    --A2 Non_Effect_allele \
    --pvalue Pvalue \
    --binary-target T \
    --cov-file /projectnb/bs859/data/tgen/cleaned/TGEN_pcs.txt \
#    --extract 02_IGAP_base_TGEN_target.valid \
    --cov-col PC6,PC8 \
    --clump-kb 500 \
    --clump-r2 0.1 \
--out 500_IGAP_base_TGEN_target

#QUESTION 1d
cat 01_IGAP_base_TGEN_target.log
cat 01_IGAP_base_TGEN_target.summary
cat 02_IGAP_base_TGEN_target.log
cat 02_IGAP_base_TGEN_target.summary
cat 05_IGAP_base_TGEN_target.log
cat 05_IGAP_base_TGEN_target.summary
cat 500_IGAP_base_TGEN_target.log
cat 500_IGAP_base_TGEN_target.summary

#QUESTION 2
Rscript $SCC_PRSICE_BIN/PRSice.R --dir . \
    --prsice $SCC_PRSICE_BIN/PRSice \
    --base /projectnb/bs859/data/hippo/Meta_Whole_hippocampus.txt.gz  \
    --target /projectnb/bs859/data/tgen/cleaned/TGEN_cleaned  \
    --stat Z \
    --beta \
    --snp SNP \
    --A1 A1 \
    --A2 A2 \
    --pvalue P \
    --binary-target T \
    --cov-file /projectnb/bs859/data/tgen/cleaned/TGEN_pcs.txt \
    --cov-col PC6,PC8 \
    --clump-kb 250 \
    --clump-r2 0.1 \
    --perm 1000 \
    --seed 542386 \
--out HIPPO_base_TGEN_target

#QUESTION 2a
cat HIPPO_base_TGEN_target.summary

#QUESTION 2f
wc -l /projectnb/bs859/data/tgen/cleaned/TGEN_cleaned.fam
