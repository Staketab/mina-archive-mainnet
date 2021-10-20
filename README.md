# MINA NODE SETUP
Setup Mina node with Archive and uploading blocks to GCloud.

## 1. Setup your GCLOUD service first
## 2. Clone repository:

```
git clone https://github.com/Staketab/mina-archive-mainnet.git
```
## 3. Copy your data (Important)

Copy your keys (my-wallet and my-wallet.pub) in your `/home/user/keys/` or `/root/keys/` folder.  

### Then set permittions:
```
chmod 700 $HOME/keys
chmod 600 $HOME/keys/my-wallet
```

And if you need to use GCP for backup blocks, don't forgot to copy your keyfile from GCP to `$HOME/mina-archive-mainnet/` folder (OPTIONAL).  

## 4. Start pre-install script:
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
```
docker-compose logs -f sidecar
```

# DONE
