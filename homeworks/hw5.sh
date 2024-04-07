module load plink2/alpha3.7
module load R

#QUESTION 2
zcat chr2.info.gz | awk -F ':' '$1 == "chr2" {count++} END {print count}'

#QUESTION 3
zcat chr2.info.gz | awk '$5 > 0.005 && $7 > 0.3 {count++} END {print count}'
zcat chr2.info.gz | wc -l

#QUESTION 5 and 6
Rscript MAFinfo.R > MAFinfo.log

#QUESTION 7
plink2 --double-id -exclude-if-info "MAF<0.005" --extract-if-info "R2>=0.3" --vcf chr2.dose.vcf.gz dosage=DS \
                                --pheno TGEN_cleaned.fam --pheno-col-nums 6 --make-pgen --out tgen_chr2_imputed
plink2 --pfile tgen_chr2_imputed --covar TGEN_pcs.txt --covar-name PC6,PC8 --logistic hide-covar --out chr2_1pcs

#A
Rscript  qqplot_pgen.R chr2_1pcs.PHENO1.glm.logistic.hybrid chr2.tgen ADD
Rscript  gwaplot_pgen.R chr2_1pcs.PHENO1.glm.logistic.hybrid "chr2.imputed" "chr2.imputed"

#B
awk 'NR > 1' chr2_1pcs.PHENO1.glm.logistic.hybrid | sort -g -k13 | head -n 4

#C
awk '$2 == 127135234' chr2_1pcs.PHENO1.glm.logistic.hybrid

#D
zcat chr2.info.gz | awk -F '\t' '$1 ~ /^chr2:127135234:.*$/'

#E
zcat chr2.dose.vcf.gz | awk '$2 == 127135234'
zcat chr2.dose.vcf.gz | head

