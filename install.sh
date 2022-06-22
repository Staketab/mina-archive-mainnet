#!/bin/bash

RED="\033[31m"
YELLOW="\033[33m"
GREEN="\033[32m"
NORMAL="\033[0m"
NODE_IP="$(curl ifconfig.me)"

function update {
curl -s https://raw.githubusercontent.com/Staketab/node-tools/main/components/docker/install.sh | bash
echo "-------------------------------------------------------------------"
echo -e "$YELLOW Components updated.$NORMAL"
echo "-------------------------------------------------------------------"
}

function confMinaNode {
echo -e "$YELLOW Enter Mina docker image. (Example: minaprotocol/mina-daemon:1.2.2-feee67c-mainnet) $NORMAL"
echo "-------------------------------------------------------------------"
read -p "Mina docker image: " MINATAG

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Enter MINA_PRIVKEY_PASS (Block Producer private key pass) $NORMAL"
echo "-------------------------------------------------------------------"
read -s MINA_PRIVKEY_PASS

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Enter UPTIME_PRIVKEY_PASS $NORMAL"
echo "-------------------------------------------------------------------"
read -s UPTIME_PRIVKEY_PASS

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Enter KEYPATH (Example: /home/username/keys/my-wallet or /root/keys/my-wallet )$NORMAL"
echo "-------------------------------------------------------------------"
read -p "KEYPATH: " KEYPATH

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Enter COINBASE_RECEIVER to transfer BP rewards on it. $NORMAL"
echo "-------------------------------------------------------------------"
read -p "COINBASE_RECEIVER: " COINBASE_RECEIVER

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Enter COINBASE_RECEIVER to transfer BP rewards on it. $NORMAL"
echo "-------------------------------------------------------------------"
read -p "COINBASE_RECEIVER: " COINBASE_RECEIVER
}

function confMinaArchive {
echo -e "$YELLOW Enter Archive docker image. (Example: minaprotocol/mina-archive:1.2.2-feee67c) $NORMAL"
echo "-------------------------------------------------------------------"
read -p "Archive docker image: " ARCHIVETAG

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Enter PGPASSWORD (Postgres user password) $NORMAL"
echo "-------------------------------------------------------------------"
read -s PGPASSWORD
}

function confGCP {
echo -e "$YELLOW Enter GCLOUD_KEYFILE. $NORMAL"
echo "-------------------------------------------------------------------"
read -p "GCLOUD KEYFILE: " GCLOUD_KEYFILE

echo "-------------------------------------------------------------------"
echo -e "$YELLOW Enter GCLOUD_BLOCK_UPLOAD_BUCKET $NORMAL"
echo "-------------------------------------------------------------------"
read -p "GCLOUD BLOCK UPLOAD BUCKET: " GCLOUD_BLOCK_UPLOAD_BUCKET
}

function confSidecar {
echo -e "$YELLOW Used Sidecar docker image: minaprotocol/mina-bp-stats-sidecar:1.1.6-386c5ac $NORMAL"
echo "-------------------------------------------------------------------"
SIDECARTAG="minaprotocol/mina-bp-stats-sidecar:1.1.6-386c5ac"
}

function install {
sudo iptables -A INPUT -p tcp --dport 8302:8302 -j ACCEPT

sudo /bin/bash -c  'echo "# Fields to start Mina daemon (Required)
MINA='${MINATAG}'
PEER_LIST=https://storage.googleapis.com/mina-seed-lists/mainnet_seeds.txt
MINA_PRIVKEY_PASS='${MINA_PRIVKEY_PASS}'
CODA_PRIVKEY_PASS='${MINA_PRIVKEY_PASS}'
UPTIME_PRIVKEY_PASS='${UPTIME_PRIVKEY_PASS}'

#PATH to your Mina private key file.
KEYPATH='${KEYPATH}'
UPTIME_KEYPATH='${KEYPATH}'
COINBASE_RECEIVER='${COINBASE_RECEIVER}'
NODE_STATUS_URL="--node-status-url https://us-central1-o1labs-192920.cloudfunctions.net/node-status-collection"
NODE_ERROR_URL="--node-error-url https://us-central1-o1labs-192920.cloudfunctions.net/node-error-collection"
UPTIME_URL="https://uptime-backend.minaprotocol.com/v1/submit"
STOP_TIME="--stop-time '${TIME:-"200"}'"

# Next fields for SIDECAR (Optional)
SIDECAR='${SIDECARTAG}'

# Next fields for Archive DB (Optional)
ARCHIVE='${ARCHIVETAG}'
POSTGRES=postgres:13.3
PGUSER=postgres
PGPASSWORD='${PGPASSWORD}'
PGDATABASE=archive
PGURI=postgres://postgres:5432/archive

# Next fields for upload blocks to GCP (Optional)
# Example: name-54f58bcv6s7.json (keyfile from your GCP, must be stored in $HOME/mina-archive-mainnet/)
GCLOUD_KEYFILE='${GCLOUD_KEYFILE}'
# Example: devnet or mainnet
NETWORK_NAME=mainnet
# Example: mina-archive-domain-com
GCLOUD_BLOCK_UPLOAD_BUCKET='${GCLOUD_BLOCK_UPLOAD_BUCKET}'
" > $HOME/mina-archive-mainnet/.env'

echo -e "$YELLOW ENV for docker-compose created.$NORMAL"
echo "-------------------------------------------------------------------"

echo -e "$GREEN ALL settings and configs created.$NORMAL"
echo "-------------------------------------------------------------------"

cd
}

update
confMinaNode
confMinaArchive
confSidecar
confGCP
install
