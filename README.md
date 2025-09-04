# Rheumatoid Arthritis Applied Genetic Analysis BS859
## Overview
Rheumatoid arthritis is a chronic autoimmune disease characterized by inflammation of the joints. Understanding the genetic basis of RA can provide insights into disease mechanisms and potential therapeutic targets. This project utilizes the North American Rheumatoid Arthritis Consortium (NARAC) dataset.

* Perform data cleaning and quality control (QC) of data.
* Conduct Principal Component Analysis (PCA) to identify population structure.
* Perform sex-specific Genome-Wide Association Studies (GWAS) analyses.
* Conduct heterogeneity analysis and meta-analysis.
* Perform Mendelian Randomization to investigate potential causal effects of BMI and smoking on RA risk.

> **Note:** The full report is not included in this repository. Only the scripts and resulting images are provided.

## Dependencies
* PLINK (1.90b6.27): Data cleaning, filtering, PCA preparation.
* GCTA (1.94.1): Mendelian Randomization and genetic relationship analyses.
* METAL: GWAS meta-analysis and heterogeneity testing.
* R (v4.3.1): Data visualization and some data wrangling.

## Data Cleaning and Quality Control
The NARAC dataset includes **2,062 individuals** (569 males, 1,493 females) and **544,276 genetic variants**. 

* Data cleaning was performed using PLINK with the following filters:
  * Minor Allele Frequency (MAF) < 0.01  
  * Missing genotype rate > 5% for individuals or SNPs  
  * Hardy-Weinberg Equilibrium (HWE) p-value < 1e-6  

After filtering, **502,304 variants and 2,062 individuals** passed quality control.  

* Heterozygosity testing and additional pruning: 
  * Differential missingness by case status to identify systematic biases.  
  * Pairwise Linkage Disequilibrium (LD) pruning to reduce redundancy: 10,000 kb window, 1-variant shift, r² threshold = 0.2.  
  * Identity-by-Descent (IBD) estimates ensured no highly related individuals were included: No pairs had >25% shared alleles, so no individuals were removed.  
  
After additional quality control steps, **107,710 variants** passed quality control.  

## Principal Component Analysis (PCA)
PCA was performed using SmartPCA to account for population structure. The first two principal components (PC1 and PC2) were most significant (p < 1e-15) and were used as covariates in downstream GWAS analyses. Outliers were identified for potential removal.

## Sex-Specific GWAS
GWAS was performed separately for males and females, using PCs as covariates, and was conducted with METAL to assess differences in effect sizes between males and females.  
* Significant variants identified (p < 0.0001):
  * Males: 19 variants (top variant: rs532098)
  * Females: 50 variants (top variant: rs9267873)

* QQ Plots: Confirmed minimal inflation; lambda values = 1.005.
* Manhattan Plots: Significant peaks observed in chromosome 6 for both sexes.

All highly significant variants are located in chromosome 6, highlighting the HLA region with minimal heterogeneity elsewhere. However, females did show stronger signals compared to males.

## Mendelian Randomization
Data preprocessing for RA, Body Mass Index (BMI), and smoking data was performed with R and GCTA. Mendelian Randomization (MR) was conducted to test causality.

### 1. BMI
* GSMR analysis revealed a total of **41,161 genome-wide significant SNPs** shared between the exposure(s) and outcome(s).
* GSMR identified **40,820 genome-wide significant SNPs** associated with BMI and RA with a p-value threshold at p < 5e-8
* Performed HEIDI outlier filtering to remove pleiotropic SNPs and removed **10 pleiotropic SNPs**

  * Effect estimate: 0.00157 (OR = 1.00157)
  * Standard Error: 0.000360589
  * p-value: 1.29812e-5

* Result: Significant but biologically negligible effects of BMI on RA risk, inconsistent with epidemiological expectations

### 2. Smoking:
* GSMR analysis revealed a total of **12,771 genome-wide significant SNPs** shared between the exposure(s) and outcome(s).
* GSMR identified **12,614 genome-wide significant SNPs** associated with smoking and RA with a p-value threshold at p < 5e-8

  * Effect estimate: 0.00206 (OR = 1.00206)
  * Standard Error: 0.000858981
  * p-value: 0.0165289

* Result: Significant but biologically negligible effects of smoking on RA risk, inconsistent with epidemiological expectations

## Acknowledgements
* Data from:
    Bridges, S.L. The North American Rheumatoid Arthritis Consortium. Arthritis Res Ther 2, 0012 (2000). https://doi.org/10.1186/ar-2000-2-webreport0012

## Author
Mabel Chang

Developed as the final project for BF528: Applications in Translational Bioinformatics at Boston University (S24)
