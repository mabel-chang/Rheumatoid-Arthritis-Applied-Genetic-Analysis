#QUESTION 1a
head /projectnb/bs859/data/T2D/T2D_Xue_et_al_2018.txt
# reformat Xue summary stats for GSMR
awk 'NR==1{print "SNP A1 A2 freq b se p N"};NR>1{print $3,$4,$5,$6,$7,$8,$9,$10}' /projectnb/bs859/data/T2D/T2D_Xue_et_al_2018.txt > T2D.ss.txt
sort -t ' ' -k 1,1 -u T2D.ss.txt > T2D.ss.dedup.txt
wc -l T2D.ss.txt T2D.ss.dedup.txt
mv T2D.ss.dedup.txt T2D.ss.txt

head /projectnb/bs859/data/T2D/T2D_European.BMIunadjusted.txt
awk 'NR==1{print "SNP A1 A2 freq b se p N"};(NR>1&&$1!="."){print $1,$5,$6,$7,$9,$10,$11,$8}' /projectnb/bs859/data/T2D/T2D_European.BMIunadjusted.txt > T2De.ss.txt
sort -t ' ' -k 1,1 -u T2De.ss.txt > T2De.ss.dedup.txt
wc T2De.ss.txt T2De.ss.dedup.txt
mv T2De.ss.dedup.txt T2De.ss.txt

head /projectnb/bs859/data/FG/MAGIC1000G_FG_EUR.tsv
awk 'NR==1{print "SNP A1 A2 freq b se p N"};NR>1{print $1,$4,$5,$6,$7,$8,$9,$10}' /projectnb/bs859/data/FG/MAGIC1000G_FG_EUR.tsv > fg.ss.txt
sort -t ' ' -k 1,1 -u fg.ss.txt > fg.ss.dedup.txt
wc -l fg.ss.txt fg.ss.dedup.txt
mv fg.ss.dedup.txt fg.ss.txt

echo "fg fg.ss.txt" > exposure.txt

echo "T2D T2D.ss.txt" > outcome.txt
echo "T2De T2De.ss.txt" >> outcome.txt

#QUESTION 1b
module load gcta/1.94.1

gcta64 --gsmr-file exposure.txt outcome.txt --bfile /projectnb/bs859/data/1000G/plinkformat/1000G_EUR --gsmr-direction 0 --out fg-T2D-gsmr --effect-plot

cat fg-T2D-gsmr.gsmr

#QUESTION 1d
module load R

Rscript --vanilla plot.R

#QUESTION 1e
cat fg-T2D-gsmr.log

#QUESTION 2a
head /projectnb/bs859/data/T2D/T2D_Xue_et_al_2018.txt
# reformat Xue summary stats for GSMR
awk 'NR==1{print "SNP A1 A2 freq b se p N"};NR>1{print $3,$4,$5,$6,$7,$8,$9,$10}' /projectnb/bs859/data/T2D/T2D_Xue_et_al_2018.txt > T2D.ss.txt
sort -t ' ' -k 1,1 -u T2D.ss.txt > T2D.ss.dedup.txt
wc -l T2D.ss.txt T2D.ss.dedup.txt
mv T2D.ss.dedup.txt T2D.ss.txt

head /projectnb/bs859/data/T2D/T2D_European.BMIunadjusted.txt
awk 'NR==1{print "SNP A1 A2 freq b se p N"};(NR>1&&$1!="."){print $1,$5,$6,$7,$9,$10,$11,$8}' /projectnb/bs859/data/T2D/T2D_European.BMIunadjusted.txt > T2De.ss.txt
sort -t ' ' -k 1,1 -u T2De.ss.txt > T2De.ss.dedup.txt
wc T2De.ss.txt T2De.ss.dedup.txt
mv T2De.ss.dedup.txt T2De.ss.txt

head /projectnb/bs859/data/lipids/HDL_INV_EUR_HRC_1KGP3_others_ALL.meta.singlevar.results
awk 'NR==1{print "SNP A1 A2 freq b se p N"};NR>1{print $1,$5,$4,$8,$9,$10,$12,$6}' /projectnb/bs859/data/lipids/HDL_INV_EUR_HRC_1KGP3_others_ALL.meta.singlevar.results > hdl.ss.txt
sort -t ' ' -k 1,1 -u hdl.ss.txt > hdl.ss.dedup.txt
wc -l hdl.ss.txt hdl.ss.dedup.txt
mv hdl.ss.dedup.txt hdl.ss.txt

echo "hdl hdl.ss.txt" > exposure.txt

echo "T2D T2D.ss.txt" > outcome.txt
echo "T2De T2De.ss.txt" >> outcome.txt

#QUESTION 2b
module load gcta/1.94.1

gcta64 --gsmr-file exposure.txt outcome.txt --bfile /projectnb/bs859/data/1000G/plinkformat/1000G_EUR --gsmr-direction 0 --out hdl-T2D-gsmr --effect-plot

cat hdl-T2D-gsmr.gsmr

#QUESTION 2c
cat hdl-T2D-gsmr.log

#QUESTION 2e
module load R

Rscript --vanilla plot.R

#QUESTION 2f
module load gcta/1.94.1

gcta64 --gsmr-file exposure.txt outcome.txt --bfile /projectnb/bs859/data/1000G/plinkformat/1000G_EUR --gsmr-direction 0 --out hdl-T2D-thresh-gsmr --effect-plot --gwas-thresh 1e-10

cat hdl-T2D-thresh-gsmr.gsmr

#QUESTION 2g
rm outcome.txt exposure.txt

echo "hdl hdl.ss.txt" > outcome.txt
echo "T2D T2D.ss.txt" > exposure.txt

gcta64 --gsmr-file exposure.txt outcome.txt --bfile /projectnb/bs859/data/1000G/plinkformat/1000G_EUR --gsmr-direction 0 --out T2D-hdl-gsmr --effect-plot

cat T2D-hdl-gsmr.gsmr
