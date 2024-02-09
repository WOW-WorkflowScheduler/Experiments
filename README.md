# Experiments

#### Prepare
To prepare the execution of the experiments:
1) Set your NFS server's IP and username in `experiment/nfsConnection.txt`; this will be used to adjust the network speed of the server.
1) Set NFS server's IP in `experiment/nfs.yaml`.
1) Create a file `experiment/nfsPassword.txt` and insert your NFS password; this will be used to adjust the network speed of the server.
1) Change the Kubernetes namespace in `experiment/namespace.txt` and in `experiment/accounts.yaml`, `experiment/nfsClaim.yaml`, `setup/dowload-pod.yaml`, maybe adjust your storage classes.
1) Label your Kubernetes nodes and adjust `experiment/nextflow_usedby.config` and `setup/download-pod.yaml` accordingly.
1) Configure the NFS Server for Kubernetes: `kubectl apply -f experiment/nfs.yaml` and `kubectl apply -f experiment/nfsClaim.yaml`

#### Setup Inputs
Go into the `setup` directory.

Placing all the inputs for a workflow into the PVC just takes two steps now:

Start the download pod (the image is built from the Dockerfile provided):
```bash
kubectl create -f download-pod.yaml
```
As soon as the task is ready you execute the script for one workflow:
```bash
bash setup-inputs.sh <workflow-name>
```

Or, alternatively, setup all the workflow inputs at once:
```bash
bash setup-all-inputs.sh
```

##### Rangeland Setup

For Rangeland, you need to download input data according to the Rangeland
[README](https://github.com/CRC-FONDA/FORCE2NXF-Rangeland). 
The `inputdata` directory in the Rangeland repository corresponds to the `/nfs/rangeland/input` directory.

#### Execute
Go into the `experiment` directory.

To run the experiments:
`bash runExperimentFromRemote.sh <strategy> <network speed>`
where `strategy` is nfs, ceph, orig-nfs, or orig-ceph.
The `network speed` is an integer.
