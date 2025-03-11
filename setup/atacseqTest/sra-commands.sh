cd /nfs/atacseqTest/input

nohup sh -c 'cat accession_nb.txt | parallel -j 20 "echo download {}; wget {};"' &
