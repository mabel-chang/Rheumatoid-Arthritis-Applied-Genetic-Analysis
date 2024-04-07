export DATADIR="/projectnb/bs859/data/1000G/1000GP_Phase3"

#print a list of the files in this directory DATADR
ls "$DATADIR"

#print out how many lines are in the sample file
wc -l "$DATADIR/1000GP_Phase3.sample"

#print out how many lines are in the chr22 file
wc -l "$DATADIR/genetic_map_chr22_combined_b37.txt"

#print the first 10 lines of the chr22 file
head "$DATADIR/genetic_map_chr22_combined_b37.txt"

#print the last 10 lines of the chr22 file
tail "$DATADIR/genetic_map_chr22_combined_b37.txt"

#command that will run the Rscript
module load R/4.3.1
Rscript "hw1_script.R"
