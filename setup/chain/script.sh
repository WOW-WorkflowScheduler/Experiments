cd $(dirname $0)

kubectl exec download-pod -- /bin/sh -c "mkdir /nfs/chain/input/ -p"
kubectl cp chain download-pod:/nfs/chain/
