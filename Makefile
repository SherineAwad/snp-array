ANNOVAR = /data/WHRI-EndocrinePituitaryGroup/software/annovar



data.ped: 
	cp GSA2016_250_025.ped data.ped 
	cp GSA2016_250_025.map data.map 
	cp GSA2016_250_025.bat data.bat 
	cp GSA2016_250_025.phenotype data.phenotype 
	cp GSA2016_250_025.script data.script


data.plink:
	plink --file data --genome --out data 

data.vcf: 
	plink --file data --recode vcf --out data 

data.bed: 
	plink --file data --maf 0.05 --make-bed --out data

data.DuplicatesRemoved.bed: 
	plink --bfile data --list-duplicate-vars ids-only suppress-first
	plink --bfile data -exclude plink.dupvar --make-bed --out data.DuplicatesRemoved

data.DuplicatesRemoved.ped: 
	plink --bfile data.DuplicatesRemoved --recode --tab --out data.DuplicatesRemoved

data.DuplicatesRemoved.vcf: 
	plink --file data.DuplicatesRemoved --recode vcf-iid --out data.DuplicatesRemoved 
data.DuplicatesRemoved_fid.vcf: 
	plink --file data.DuplicatesRemoved --recode vcf-fid --out data.DuplicatesRemoved_fid

data.assoc.plink:
	plink --file data --assoc --out data.assoc

GSA2016anno.vcf: 
	${ANNOVAR}/table_annovar.pl plink.vcf  ${ANNOVAR}/humandb/ -buildver hg19 -out GSA2016anno -remove -protocol refGene,ensGene,cytoBand,exac03,gnomad_exome,avsnp147,\
	dbnsfp30a,clinvar_20170130,mitimpact2,revel -operation g,g,f,f,f,f,f,f,f,f  -nastring . -vcfinput 
 
