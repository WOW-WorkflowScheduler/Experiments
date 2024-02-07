# error if $1 is not cws or la

if [ "$1" != "ceph" ] && [ "$1" != "nfs" ] && [ "$1" != "orig-ceph" ] && [ "$1" != "orig-nfs" ]
then
    echo "No storage supplied (ceph/nfs)"
    exit 1
fi

if ! [[ "$2" =~ ^[0-9]+$ ]]; then
    echo "No speed supplied (1/10/...)gbit (only as int)"
    exit 1
fi

if [ "$2" -lt 1 ] || [ "$2" -gt 10 ]; then
    echo "Speed must be between 1 and 10"
    exit 1
fi

bash setup.sh $1
sleep 20
bash upload.sh
name=/experiments/results/$(date '+%Y-%m-%d--%H-%M-%S').log
kubectl exec -n $(cat namespace.txt) nextflow -- /bin/bash -c "mkdir /experiments/results/ -p && nohup bash runExperiments.sh $1 $2 &> $name & echo done"