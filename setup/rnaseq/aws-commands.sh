mkdir -p rnaseq/input/ref
cd rnaseq/input/ref

aws s3 --no-sign-request cp s3://ngi-igenomes/igenomes/Homo_sapiens/Ensembl/GRCh37/Sequence/WholeGenomeFasta/genome.fa genome.fa
aws s3 --no-sign-request cp s3://ngi-igenomes/igenomes/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf genes.gtf
aws s3 --no-sign-request cp s3://ngi-igenomes/igenomes/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.bed genes.bed
aws s3 --no-sign-request sync s3://ngi-igenomes/igenomes/Homo_sapiens/Ensembl/GRCh37/Sequence/STARIndex/ STARIndex/
