kubectl apply -f daemon.yaml >/dev/null
kubectl rollout status daemonset node-shell -n default >/dev/null
IFS=$'\n'
nodes=`kubectl get pods -n default -o=jsonpath='{range .items[*]}{.spec.nodeName} {.metadata.name}{"\n"}{end}' | grep node-shell`
echo "node;dataOnNode"
for node in $nodes
do
    cnode=`echo $node | awk '{print$1}'`
    pod=`echo $node | awk '{print$2}'`
    dataOnNode=`kubectl exec -n default $pod -- du -s$1 /localdata | awk '{print$1}'`
    echo "$cnode;$dataOnNode"
done
kubectl delete -f daemon.yaml --wait >/dev/null

