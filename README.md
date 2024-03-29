# MINA NODE SETUP
Setup Mina node with Archive and uploading blocks to GCloud.

## 1. Setup your GCLOUD service first
## 2. Clone repository:

```
git clone https://github.com/Staketab/mina-archive-mainnet.git
```
And if you need to use GCP for backup blocks, don't forgot to copy your keyfile from GCP to `$HOME/mina-archive-mainnet/` folder (OPTIONAL).  

## 3. Start pre-install script:
```
cd mina-archive-mainnet \
&& chmod +x install.sh \
&& ./install.sh
```
## 4. Start the Node
Run this command to start the node:  
```
docker-compose up -d
```

Other commands:
1. Check status
```
docker exec -it mina mina client status
```
2. Stop docker-compose
```
docker-compose down
```
3. Docker-compose logs
```
docker-compose logs -f mina
```
```
docker-compose logs -f archive
```
```
docker-compose logs -f postgres
```

# DONE
