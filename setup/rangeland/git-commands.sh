cd rangeland
git clone https://github.com/CRC-FONDA/FORCE2NXF-Rangeland.git full-repo
rm -f input rangeland
mv full-repo/inputdata input
mv full-repo/nextflowWF rangeland
rm -rf full-repo
mv rangeland/workflow-dsl2.nf rangeland/main.nf
