##QUESTION 1
module load R

Rscript --vanilla SMMAT_tgen1905.R > SMMAT_tgen1905.log
Rscript --vanilla SMMAT_tgen1901.R > SMMAT_tgen1901.log

#Q1.a
wc -l annotated_imputed_vcfs/tgen.psam

#Q1.b
awk -F ',' '$2==1 {count++} END {print count}' chr19.exonic05.csv
awk -F ',' '$2==1 {count++} END {print count}' chr19.exonic01.csv

#Q1.c
awk -F ',' '$2>=2 && $17<10 {count++} END {print count}' chr19.exonic05.csv
awk -F ',' '$2>=2 && $17<10 {count++} END {print count}' chr19.exonic01.csv

#QUESTION 2
Rscript --vanilla SMMAT_tgen19eq.R > SMMAT_tgen19eq.log

#Q2.a
awk -F ',' '$2>=2 && $17>=10 {print}' chr19.exonic05eq.csv > chr19.exonic05eqtrim.csv
wc -l chr19.exonic05eqtrim.csv