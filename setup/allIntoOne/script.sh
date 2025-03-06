cd $(dirname $0)

kubectl exec download-pod -- /bin/sh -c "mkdir /nfs/allIntoOne/input/ -p"
kubectl cp allIntoOne download-pod:/nfs/allIntoOne/

