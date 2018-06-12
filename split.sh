#!/bin/sh
#$ -cwd            # Set the working directory for the job to the current directory
#$ -V
#$ -l h_rt=144:0:0  # Request 24 hour runtime
#$ -l h_vmem=20G    # Request 1GB RAM / core, i.e. 4GB total



cd /data2/WHRI-EndocrinePituitaryGroup/sherine/snp-array 

module load tabix 
module load bcftools 
module load vcftools

for sample in `bcftools query -l data.DuplicatesRemoved.vcf`
        do
        vcf-subset --exclude-ref -c $sample data.DuplicatesRemoved.vcf > "${sample}.vcf"
        done


