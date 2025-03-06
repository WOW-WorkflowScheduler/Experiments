cd $(dirname $0)

kubectl exec download-pod -- /bin/sh -c "mkdir /nfs/group/input/ -p"
kubectl cp group download-pod:/nfs/group/
