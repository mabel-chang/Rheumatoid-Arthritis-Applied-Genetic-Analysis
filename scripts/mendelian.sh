module load gcta/1.94.1
zcat /projectnb/bs859/data/RheumatoidArthritis/ukbb/M13_RHEUMA.gwas.imputed_v3.both_sexes.tsv.gz | awk -F '[: ]' '{gsub(/[A-Za-z]+/, "", $1); sub(/^[0-9]+:/, "rs", $1); print "rs" $1}' > M13_RHEUMA.gwas.imputed_v3.both_sexes.tsv
awk 'NR==1{print "rsid alt ref AF beta se pval n_complete_samples"};NR>1{print $1,$2,$3,$4,$5,$6,$7,$8}' M13_RHEUMA.gwas.imputed_v3.both_sexes.tsv > RHEUMA.ss.txt
awk -F '[: ]' '{gsub(/[A-Za-z]+/, "", $1); sub(/^[0-9]+:/, "rs", $1); print "rs" $1}' file.txt
sort -k1,1 -u -t' ' RHEUMA.ss.txt > RHEUMA.ss.dedup.txt
mv RHEUMA.ss.dedup.txt RHEUMA.ss.txt
echo "RHEUMA RHEUMA.ss.txt" > rheuma_outcome.txt

awk 'NR==1{print "SNP A1 A2 freq b se p N"}; NR>1{print $3, $4, $5, $6, $7, $8, $9, $10}' /projectnb/bs859/data/bmi/Meta-analysis_Locke_et_al+UKBiobank_2018_UPDATED.txt > BMI.ss.txt
sort -k1,1 -u -t' ' BMI.ss.txt > BMI.ss.dedup.txt
mv BMI.ss.dedup.txt BMI.ss.txt
echo "BMI BMI.ss.txt" > bmi_exposure.txt

awk 'NR==1{print "MarkerName A1 A2 EAF_A1 Beta SE Pval N"};NR>1 && !/NA/{gsub(/"/,"",$1); gsub(/"/,"",$4); gsub(/"/,"",$5); gsub(/"/,"",$6); gsub(/"/,"",$7); gsub(/"/,"",$8); gsub(/"/,"",$9); gsub(/"/,"",$10); print $1,$4,$5,$6,$7,$8,$9,$10}' /projectnb/bs859/data/smoking/EVER_SMOKER_GWAS_MA_UKB+TAG.txt > SM.ss.txt
sort -t ' ' -k 1,1 -u SM.ss.txt > SM.ss.dedup.txt
mv SM.ss.dedup.txt SM.ss.txt
echo "SM SM.ss.txt" > sm_exposure.txt

gcta64 --gsmr-file bmi_exposure.txt RHEUMA_outcome.txt --bfile /projectnb/bs859/data/1000G/plinkformat/1000G_EUR --gsmr-direction 0 --out BMI_RHEUMA_gsmr --effect-plot
gcta64 --gsmr-file SM_exposure.txt RHEUMA_outcome.txt --bfile /projectnb/bs859/data/1000G/plinkformat/1000G_EUR --gsmr-direction 0 --out SM_RHEUMA_gsmr --effect-plot

Rscript --vanilla plot.R
