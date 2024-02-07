# check nfspassword.txt exists
if [ ! -f nfspassword.txt ]; then
    echo "No nfspassword.txt found"
    exit 1
fi
kubectl cp ../experiment $(cat namespace.txt)/nextflow:/experiments