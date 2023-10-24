# X-omics Docker containers collection
A collection of Docker containers that are used in X-omics workflows

# Dockerhub
Containers in this repository can be pulled from [Dockerhub](https://hub.docker.com/u/casperdevisser)

# Build Docker images locally
Docker images can be built locally using the Dockerfiles in this repository, for example: 

```{bash}
git clone https://github.com/Xomics/Docker_containers.git
cd Docker_containers/miniconda-snf
docker build -t image/name:$VERSION .
```

# Build Singularity containers **locally**

### Create Docker image, convert to Singularity

Define a Dockerfile (example: *Container_files\r-base-phenotypes\Dockerfile*), build Docker image, push to registry, save to archive, and convert to Singularity image.

Build Docker image locally and push to the Gitlab registry:
```{bash}
docker login registry.cmbi.umcn.nl
docker build -t registry.cmbi.umcn.nl/${repository_name}/r-base-phenotypes:$VERSION .
docker push registry.cmbi.umcn.nl/${repository_name}/r-base-phenotypes:$VERSION
```

Run in a DRE VM (or locally):
```{bash}
docker pull registry.cmbi.umcn.nl/${repository_name}/r-base-phenotypes:$VERSION
docker images # to get IMAGE_ID
docker save $IMAGE_ID -o r-base-phenotypes.tar
sudo singularity build r-base-phenotypes.sif docker-archive://r-base-phenotypes.tar
```
