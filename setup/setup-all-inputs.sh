cd $(dirname $0)

# synthetic workflows
bash setup-inputs.sh Synthetic_Blast_200
bash setup-inputs.sh Synthetic_Bwa_200
bash setup-inputs.sh Synthetic_Cycles_200
bash setup-inputs.sh Synthetic_Genome_200
bash setup-inputs.sh Synthetic_Montage_200
bash setup-inputs.sh Synthetic_Seismology_200
bash setup-inputs.sh Synthetic_Soykb_200

# workflow patterns
bash setup-inputs.sh allIntoOne
bash setup-inputs.sh chain
bash setup-inputs.sh fork
bash setup-inputs.sh group
bash setup-inputs.sh groupMultiple

# real workflows
bash setup-inputs.sh rangeland
bash setup-inputs.sh chipseq
bash setup-inputs.sh rnaseq
bash setup-inputs.sh sarek
