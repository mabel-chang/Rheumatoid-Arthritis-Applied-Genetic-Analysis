##QUESTION 2
module load gcta/1.94.1

zcat UKB.v2.albuminuria.n382500.sorted.tsv.gz|awk '{print $2,$5,$6,$7,$8,$9,$10,$11}' > togcta.txt

#QUESTION 2.a
gcta64 --bfile /projectnb/bs859/data/1000G/plinkformat/1000G_EUR --cojo-file togcta.txt --cojo-slct --chr 12 --out chr12EUR > chr12EUR.log

cat chr12EUR.log

wc chr12EUR.jma.cojo
head chr12EUR.jma.cojo

wc chr12EUR.freq.badsnps
awk '$1=="rs2601006" {print}' chr12EUR.freq.badsnps

#QUESTION 2.b
gcta64 --bfile /projectnb/bs859/data/1000G/plinkformat/1000G_AFR --cojo-file togcta.txt --cojo-slct --chr 12 --out chr12.AFR > chr12AFR.log

cat chr12AFR.log

wc chr12.AFR.jma.cojo
head chr12.AFR.jma.cojo

wc chr12.AFR.freq.badsnps
awk '$1=="rs2601006"||$1=="rs710684" {print}' chr12.AFR.freq.badsnps

##QUESTION 3
zcat UKB.v2.albuminuria.n382500.sorted.tsv.gz|awk 'NR==1||$2=="rs2601006"||$2=="rs710684" {print $0}' > p5e-7.txt

cut -f2 p5e-7.txt > toVEP.txt

nano VEPres.txt