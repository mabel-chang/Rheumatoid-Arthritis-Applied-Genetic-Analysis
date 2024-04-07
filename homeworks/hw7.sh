#QUESTION 2
module load metal
metal metal_hw7.txt > metal_hw7.log

#QUESTION 2a
zcat Uganda_BMI_GWAS_MAF01.txt.gz | awk 'NR == 1 || $1 == "10:100003534:G:A"'

#QUESTION 2b
module load R
Rscript --vanilla qqplot.R  ZscoreMeta1.tbl Metal1
Rscript --vanilla gwaplot.R ZscoreMeta1.tbl "MetalMan1" "MetalMan1"

#QUESTION 3
awk '$6 < 5e-8 {print}' ZscoreMeta1.tbl

#QUESTION 3a
zcat Uganda_BMI_GWAS_MAF01.txt.gz | awk 'NR == 1 || $1 == "19:45954045:A:G" || $1 == "11:56591541:T:G"'

#QUESTION 3d
awk 'NR ==1 || $1 == "19:45954045:A:G" || $1 == "11:56591541:T:G" {print}' ZscoreMeta1.tbl

#QUESTION 4
awk 'NR ==1 || $1 == "7:141551191:C:T" || $1 == "7:141549317:A:G" {print}' ZscoreMeta1.tbl

#QUESTION 4c
zcat Uganda_BMI_GWAS_MAF01.txt.gz | awk 'NR == 1 || $1 == "7:141551191:C:T" || $1 == "7:141549317:A:G"'
