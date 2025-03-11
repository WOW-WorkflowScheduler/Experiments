mkdir -p sarekTest/input/
cd sarekTest/input/

aws s3 --no-sign-request cp s3://ngi-igenomes/igenomes/Homo_sapiens/GATK/GRCh38/Annotation/Sentieon/SentieonDNAscopeModel1.1.model SentieonDNAscopeModel1.1.model
