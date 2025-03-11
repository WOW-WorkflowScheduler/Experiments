cd $(dirname $0)

kubectl exec download-pod -- mkdir -p atacseqTest/input

# copy data csvs to download-pod
kubectl cp samplesheet_test.csv download-pod:/nfs/atacseqTest/input
# download atacseq git repository
kubectl exec download-pod -- /bin/sh -c "`cat git-commands.sh`"
# overwrite atacseq config
kubectl cp modules.config download-pod:/nfs/atacseqTest/atacseqTest/conf/modules.config

# copy list of accession numbers to download-pod
kubectl cp accession_nb.txt download-pod:/nfs/atacseqTest/input
# download and extract data from NCBI's SRA
echo "Start downloading data from SRA..."
kubectl exec download-pod -- /bin/sh -c "`cat sra-commands.sh`"