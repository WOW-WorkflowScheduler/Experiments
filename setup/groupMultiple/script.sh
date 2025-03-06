cd $(dirname $0)

kubectl exec download-pod -- /bin/sh -c "mkdir /nfs/groupMultiple/input/ -p"
kubectl cp groupMultiple download-pod:/nfs/groupMultiple/
