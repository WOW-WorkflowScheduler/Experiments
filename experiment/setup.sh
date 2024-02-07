kubectl apply -f accounts.yaml -n $(cat namespace.txt)
kubectl apply -f pvc.yaml -n $(cat namespace.txt)
kubectl apply -f $1-pod.yaml -n $(cat namespace.txt)
kubectl wait --for=condition=ready pod nextflow -n $(cat namespace.txt)
kubectl exec -n $(cat namespace.txt) nextflow -- bash -c "apk add tar rsync openssh sshpass || yum install tar rsync openssh-server openssh-clients sshpass wget -y; wget https://archives.fedoraproject.org/pub/archive/epel/6/x86_64/epel-release-6-8.noarch.rpm; rpm -ivh epel-release-6-8.noarch.rpm; rm epel-release-6-8.noarch.rpm; yum --enablerepo=epel -y install sshpass"
kubectl exec -n $(cat namespace.txt) nextflow -- bash -c "cd /usr/local/bin/ && curl -LO 'https://dl.k8s.io/release/v1.28.3/bin/linux/amd64/kubectl' && chmod 700 kubectl"