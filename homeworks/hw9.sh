#QUESTION 1
export LDSCORES_DIR='/projectnb/bs859/data/ldscore_files'
module load R
module load python2
module load ldsc

munge_sumstats.py \
--sumstats jointGwasMc_LDL.txt.gz \
--snp rsid \
--N-col N \
--a1 A1 \
--a2 A2 \
--signed-sumstats Beta,0 \
--merge-alleles $LDSCORES_DIR/w_hm3.snplist \
--out LDL

ldsc.py \
--h2 LDL.sumstats.gz \
--ref-ld $LDSCORES_DIR/UKBB.ALL.ldscore/UKBB.EUR.rsid \
--w-ld $LDSCORES_DIR/UKBB.ALL.ldscore/UKBB.EUR.rsid \
--out LDL_UKBB

ldsc.py \
--h2 LDL.sumstats.gz \
--ref-ld $LDSCORES_DIR/UKBB.ALL.ldscore/UKBB.EUR.rsid \
--w-ld $LDSCORES_DIR/UKBB.ALL.ldscore/UKBB.EUR.rsid \
--pop-prev 0.54 \
--samp-prev 0.498 \
--out LDL_PREV_UKBB

#QUESTION 2
munge_sumstats.py \
--sumstats jointGwasMc_HDL.txt.gz \
--snp rsid \
--N-col N \
--a1 A1 \
--a2 A2 \
--signed-sumstats Beta,0 \
--merge-alleles $LDSCORES_DIR/w_hm3.snplist \
--out HDL

ldsc.py \
--h2 HDL.sumstats.gz \
--ref-ld $LDSCORES_DIR/UKBB.ALL.ldscore/UKBB.EUR.rsid \
--w-ld $LDSCORES_DIR/UKBB.ALL.ldscore/UKBB.EUR.rsid \
--out HDL_UKBB

ldsc.py \
--h2 HDL.sumstats.gz \
--ref-ld $LDSCORES_DIR/UKBB.ALL.ldscore/UKBB.EUR.rsid \
--w-ld $LDSCORES_DIR/UKBB.ALL.ldscore/UKBB.EUR.rsid \
--pop-prev 0.266 \
--samp-prev 0.498 \
--out HDL_PREV_UKBB

#QUESTION 3
munge_sumstats.py \
--sumstats /projectnb/bs859/data/igap/Kunkle_etal_Stage1_results2019.txt.gz \
--snp MarkerName \
--N-cas 21982 \
--N-con 41944 \
--a1 Effect_allele \
--a2 Non_Effect_allele \
--signed-sumstats Beta,0 \
--merge-alleles $LDSCORES_DIR/w_hm3.snplist \
--out AD

ldsc.py \
--rg LDL.sumstats.gz,HDL.sumstats.gz,AD.sumstats.gz \
--ref-ld $LDSCORES_DIR/UKBB.ALL.ldscore/UKBB.EUR.rsid \
--w-ld $LDSCORES_DIR/UKBB.ALL.ldscore/UKBB.EUR.rsid \
--out LDL_HDL_AD_rg

ldsc.py \
--rg HDL.sumstats.gz,AD.sumstats.gz \
--ref-ld $LDSCORES_DIR/UKBB.ALL.ldscore/UKBB.EUR.rsid \
--w-ld $LDSCORES_DIR/UKBB.ALL.ldscore/UKBB.EUR.rsid \
--out HDL_AD_rg

#QUESTION 5
ldsc.py \
 --h2 AD.sumstats.gz \
--ref-ld-chr $LDSCORES_DIR/1000G_Phase3_cell_type_groups/cell_type_group.1.,$LDSCORES_DIR/1000G_EUR_Phase3_baseline/baseline.  \
--w-ld-chr  $LDSCORES_DIR/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--overlap-annot \
--frqfile-chr $LDSCORES_DIR/1000G_Phase3_frq/1000G.EUR.QC. \
--pop-prev 0.10 \
--samp-prev 0.344 \
--out G1 \
--print-coefficients

ldsc.py \
 --h2 AD.sumstats.gz \
--ref-ld-chr $LDSCORES_DIR/1000G_Phase3_cell_type_groups/cell_type_group.2.,$LDSCORES_DIR/1000G_EUR_Phase3_baseline/baseline.  \
--w-ld-chr  $LDSCORES_DIR/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--overlap-annot \
--frqfile-chr $LDSCORES_DIR/1000G_Phase3_frq/1000G.EUR.QC. \
--pop-prev 0.10 \
--samp-prev 0.344 \
--out G2 \
--print-coefficients

ldsc.py \
 --h2 AD.sumstats.gz \
--ref-ld-chr $LDSCORES_DIR/1000G_Phase3_cell_type_groups/cell_type_group.3.,$LDSCORES_DIR/1000G_EUR_Phase3_baseline/baseline.  \
--w-ld-chr  $LDSCORES_DIR/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--overlap-annot \
--frqfile-chr $LDSCORES_DIR/1000G_Phase3_frq/1000G.EUR.QC. \
--pop-prev 0.10 \
--samp-prev 0.344 \
--out G3 \
--print-coefficients

ldsc.py \
 --h2 AD.sumstats.gz \
--ref-ld-chr $LDSCORES_DIR/1000G_Phase3_cell_type_groups/cell_type_group.4.,$LDSCORES_DIR/1000G_EUR_Phase3_baseline/baseline.  \
--w-ld-chr  $LDSCORES_DIR/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--overlap-annot \
--frqfile-chr $LDSCORES_DIR/1000G_Phase3_frq/1000G.EUR.QC. \
--pop-prev 0.10 \
--samp-prev 0.344 \
--out G4 \
--print-coefficients

ldsc.py \
 --h2 AD.sumstats.gz \
--ref-ld-chr $LDSCORES_DIR/1000G_Phase3_cell_type_groups/cell_type_group.5.,$LDSCORES_DIR/1000G_EUR_Phase3_baseline/baseline.  \
--w-ld-chr  $LDSCORES_DIR/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--overlap-annot \
--frqfile-chr $LDSCORES_DIR/1000G_Phase3_frq/1000G.EUR.QC. \
--pop-prev 0.10 \
--samp-prev 0.344 \
--out G5 \
--print-coefficients

ldsc.py \
 --h2 AD.sumstats.gz \
--ref-ld-chr $LDSCORES_DIR/1000G_Phase3_cell_type_groups/cell_type_group.6.,$LDSCORES_DIR/1000G_EUR_Phase3_baseline/baseline.  \
--w-ld-chr  $LDSCORES_DIR/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--overlap-annot \
--frqfile-chr $LDSCORES_DIR/1000G_Phase3_frq/1000G.EUR.QC. \
--pop-prev 0.10 \
--samp-prev 0.344 \
--out G6 \
--print-coefficients

ldsc.py \
 --h2 AD.sumstats.gz \
--ref-ld-chr $LDSCORES_DIR/1000G_Phase3_cell_type_groups/cell_type_group.7.,$LDSCORES_DIR/1000G_EUR_Phase3_baseline/baseline.  \
--w-ld-chr  $LDSCORES_DIR/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--overlap-annot \
--frqfile-chr $LDSCORES_DIR/1000G_Phase3_frq/1000G.EUR.QC. \
--pop-prev 0.10 \
--samp-prev 0.344 \
--out G7 \
--print-coefficients

ldsc.py \
 --h2 AD.sumstats.gz \
--ref-ld-chr $LDSCORES_DIR/1000G_Phase3_cell_type_groups/cell_type_group.8.,$LDSCORES_DIR/1000G_EUR_Phase3_baseline/baseline.  \
--w-ld-chr  $LDSCORES_DIR/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--overlap-annot \
--frqfile-chr $LDSCORES_DIR/1000G_Phase3_frq/1000G.EUR.QC. \
--pop-prev 0.10 \
--samp-prev 0.344 \
--out G8 \
--print-coefficients

ldsc.py \
 --h2 AD.sumstats.gz \
--ref-ld-chr $LDSCORES_DIR/1000G_Phase3_cell_type_groups/cell_type_group.9.,$LDSCORES_DIR/1000G_EUR_Phase3_baseline/baseline.  \
--w-ld-chr  $LDSCORES_DIR/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--overlap-annot \
--frqfile-chr $LDSCORES_DIR/1000G_Phase3_frq/1000G.EUR.QC. \
--pop-prev 0.10 \
--samp-prev 0.344 \
--out G9 \
--print-coefficients

ldsc.py \
 --h2 AD.sumstats.gz \
--ref-ld-chr $LDSCORES_DIR/1000G_Phase3_cell_type_groups/cell_type_group.10.,$LDSCORES_DIR/1000G_EUR_Phase3_baseline/baseline.  \
--w-ld-chr  $LDSCORES_DIR/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--overlap-annot \
--frqfile-chr $LDSCORES_DIR/1000G_Phase3_frq/1000G.EUR.QC. \
--pop-prev 0.10 \
--samp-prev 0.344 \
--out G10 \
--print-coefficients


head -n 1 "$(ls *.results | head -n 1)" > G_all.results
for file in *.results; do sed -n "2s/^/$file\t/p" "$file"; done >> G_all.results
sed -i '1s/^/file_name  /' G_all.results

