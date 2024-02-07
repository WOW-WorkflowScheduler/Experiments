#!/bin/bash
# check that $1 is set and larger than 1000
if [ -z "$1" ] || [ "$1" -lt 1000 ]; then
    echo "Please provide a rate larger than 1000"
    exit 1
fi

node_names=($(kubectl get nodes -o=jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'))

function check_pod_status() {
  local status=$(kubectl get pod $1 -n flehmann -o jsonpath='{.status.phase}')
  if [[ "$status" == "Succeeded" || "$status" == "Failed" ]]; then
    return 0
  fi
  return 1
}

function update_nodeshell_yaml() {
    node_name=$1
    sed "s/SetNodeNameHere/$node_name/g" nodeshell.yaml > nodeshell_${node_name}.yaml

    # replace also SetRateHere
    sed -i "s/SetRateHere/$2/g" nodeshell_${node_name}.yaml

    kubectl apply -f nodeshell_${node_name}.yaml
    rm nodeshell_${node_name}.yaml
}

for node in "${node_names[@]}"; do
    update_nodeshell_yaml "$node" "$1"
done
for node in "${node_names[@]}"; do
    while ! check_pod_status node-shell-${node}; do
        sleep 1
    done
    kubectl delete pod -n flehmann node-shell-${node}
done

echo "Update NFS server"
echo $(cat nfspassword.txt) | sshpass -p $(cat nfspassword.txt) ssh $(cat nfsConnection.txt) -tt -o StrictHostKeyChecking=no "sudo /bin/bash /tcconfig/setup.sh '$1'"