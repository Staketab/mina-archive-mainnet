#!/bin/bash

KEY=$(cat $HOME/keys/my-wallet.pub)
KEYDEST="$HOME/.mina-config/wallets/store/${KEY}"
    if [ ! -f "$KEYDEST" ]; then
        mina accounts import --privkey-path $HOME/keys/my-wallet
    fi
