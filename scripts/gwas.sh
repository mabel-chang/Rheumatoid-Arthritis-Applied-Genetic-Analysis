module load R
module load plink/1.90b6.27

#A
#create list of males IDs
awk '$5 == 1' narac_hg19_pca.fam > male_ids.txt
#create list of females IDs
awk '$5 == 2' narac_hg19_pca.fam > female_ids.txt
#subset males
plink --bfile narac_hg19_pca --keep male_ids.txt --make-bed --out male_data
#subset females
plink --bfile narac_hg19_pca --keep female_ids.txt --make-bed --out female_data
# For males
plink --bfile male_data --covar narac_hg19_pca_converted --covar-name PC_1, PC_2 --logistic beta hide-covar --ci .95 --out narac_hg19_male_hidecov
# For females
plink --bfile female_data --covar narac_hg19_pca_converted --covar-name PC_1, PC_2 --logistic beta hide-covar --ci .95 --out narac_hg19_female_hidecov

#count variants
awk 'NR == 1 {next} $12 < 0.0001 {print | "sort -g -k12 > narac_hg19_male_hidecov.assoc.logistic_sig"}' narac_hg19_male_hidecov.assoc.logistic
wc -l narac_hg19_male_hidecov.assoc.logistic_sig
awk 'NR == 1 {next} $12 < 0.0001 {print | "sort -g -k12 > narac_hg19_female_hidecov.assoc.logistic.sig"}' narac_hg19_female_hidecov.assoc.logistic
wc -l narac_hg19_female_hidecov.assoc.logistic.sig
#most significant
head narac_hg19_male_hidecov.assoc.logistic_sig
head narac_hg19_female_hidecov.assoc.logistic.sig

#qqplot
Rscript --vanilla qqplot.R narac_hg19_male_hidecov.assoc.logistic narac_male ADD 
Rscript --vanilla qqplot.R narac_hg19_female_hidecov.assoc.logistic narac_female ADD 

#Manhattan Plot
Rscript --vanilla gwaplot_pgen.R narac_hg19_male_hidecov.assoc.logistic "NARAC Male Manhattan" narac_male_manhattan 
Rscript --vanilla gwaplot_pgen.R narac_hg19_female_hidecov.assoc.logistic "NARAC Female Manhattan" narac_female_manhattan 

#B
module load metal 

metal metal.txt > metal.log 
Rscript qq_plot.R 

Rscript gwaplot_pgen.R 

awk 'NR==1 || $6 < 5e-8' ZscoreMeta1.tbl 



awk '$6 == "6:32578052:A:G"' merged_male_data.logistic.txt
awk '$6 == "6:32215188:A:G"' merged_male_data.logistic.txt