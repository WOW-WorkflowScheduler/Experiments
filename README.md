# Experiments

#### Prepare
To prepare the execution of the experiments, go into the `experiment` folder:
1) Set your NFS server's IP and username in `nfsConnection.txt`; this will be used to adjust the network speed of the server.
1) Set NFS server's IP in `nfs.yaml`.
1) Create a file `nfsPassword.txt` and insert your NFS password; this will be used to adjust the network speed of the server.
1) Change the Kubernetes namespace in `namespace.txt` and in `accounts.yaml`, `nfsClaim.yaml`, maybe adjust your storage classes.
1) Label your Kubernetes nodes and adjust `nextflow_usedby.config` accordingly.
1) Configure the NFS Server for Kubernetes: `kubectl apply -f nfs.yaml` and `kubectl apply -f nfsClaim.yaml`

#### Execute
To run the experiments:
`bash runExperimentFromRemote.sh <strategy> <network speed>`
where `strategy` is nfs, ceph, orig-nfs, or orig-ceph.
The `network speed` is an integer.