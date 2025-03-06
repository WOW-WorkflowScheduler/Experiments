cd $(dirname $0)

kubectl exec download-pod -- /bin/sh -c "mkdir /nfs/fork/input/ -p"
kubectl cp fork download-pod:/nfs/fork/
