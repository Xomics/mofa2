# Docker container for running Multi-Omics Factor Analysis [(Argelaguet et al, 2019)](https://doi.org/10.15252/msb.20178124)


## Pull Docker image
```{bash}
docker pull casperdevisser/mofa2:v0.6 #latest
```

## Build Docker image 

```{bash}
# Dockerfile VERSION = v0.6
docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')  -t casperdevisser/mofa2:$VERSION . 
```