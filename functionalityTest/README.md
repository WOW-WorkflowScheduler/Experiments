# Functionality Test

This repository contains a functionality test with modified script files:  
- `runExperimentFromRemote.sh`  
- `runExperiments.sh`  
- `setup.sh`  

## Overview  

The experiments are adjusted so they do **not** execute over a network.  
- No **Ceph** or **NFS** is created.  
- Instead, the local storage maps into the mem disk and the shared storage onto the hosts physical disk.
- However, the examples are pretty small and **no performance improvements** might be observed — this is purely a functionality test.  

Additionally, the repository includes a `kind-config.yaml` file for a minimal **kind** configuration.  
Ensure **kind** is installed on your machine before proceeding.  
[Installation Guide](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)  

## Running the Functionality Test  

We recommend executing `setupKind.sh` **line by line** to set up the environment.  

#### Adjusting RAM Disk Size  

If your machine **cannot allocate ~15GB** to the RAM disk, you can reduce this part in all `nextflow.config` files within the folders:  
- `allIntoOne`  
- `chain`  
- `fork`  
- `group`  
- `groupMultiple`  

Modify the following parameters:  
```groovy
params {
    minSizeGB = 0.1
    maxSizeGB = 0.2
    numberOfTasks = 20
}
```

### Running Experiments  

The functionality was confirmed on **Ubuntu 22.04**.  

#### With WOW and CWS:  
```bash
bash runExperimentFromRemote.sh ceph
```

#### With the Original Nextflow:  
```bash
bash runExperimentFromRemote.sh orig-ceph
```

### Experiment Results  

If you **did not modify** the `kind-config.yaml`, the results are stored at:  `/tmp/kind/data/shared-experiments` as described in the [Results and Evaluation](https://github.com/WOW-WorkflowScheduler/ResultsAndEvaluation) repository.  

This directory also contains the logs of the current run.  