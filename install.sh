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
echo -e "$YELLOW Enter Mina docker image. (Example: minaprotocol/mina-daemon:1.3.1.1-f361ba1-bionic-mainnet) $NORMAL"
echo "-------------------------------------------------------------------"
read -p "Mina docker image: " MINATAG
}

function confMinaArchive {
echo -e "$YELLOW Enter Archive docker image. (Example: minaprotocol/mina-archive:1.3.1.1-f361ba1-bionic) $NORMAL"
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

function install {
sudo iptables -A INPUT -p tcp --dport 8302:8302 -j ACCEPT

sudo /bin/bash -c  'echo "# Fields to start Mina daemon (Required)
MINA='${MINATAG}'
PEER_LIST=https://storage.googleapis.com/mina-seed-lists/mainnet_seeds.txt

#PATH to your Mina private key file.
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
confGCP
install
