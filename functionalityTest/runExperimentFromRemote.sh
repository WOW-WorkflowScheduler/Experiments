# error if $1 is not cws or la

if [ "$1" != "ceph" ] && [ "$1" != "nfs" ] && [ "$1" != "orig-ceph" ] && [ "$1" != "orig-nfs" ]
then
    echo "No storage supplied (ceph/nfs)"
    exit 1
fi

bash setup.sh $1
sleep 20
kubectl cp ../experiment nextflow:/experiments
# overwrite the runExperiments.sh script
kubectl cp runExperiments.sh nextflow:/experiments/experiment/runExperiments.sh
kubectl cp allIntoOne nextflow:/experiments/experiment/
kubectl cp chain nextflow:/experiments/experiment/
kubectl cp fork nextflow:/experiments/experiment/
kubectl cp group nextflow:/experiments/experiment/
kubectl cp groupMultiple nextflow:/experiments/experiment/
name=/experiments/results/$(date '+%Y-%m-%d--%H-%M-%S').log
kubectl exec nextflow -- /bin/bash -c "mkdir /experiments/results/ -p && nohup bash runExperiments.sh $1 &> $name & echo done"