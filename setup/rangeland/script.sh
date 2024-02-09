cd $(dirname $0)

kubectl exec download-pod -- mkdir -p rangeland
kubectl exec download-pod -- /bin/sh -c "`cat git-commands.sh`"
