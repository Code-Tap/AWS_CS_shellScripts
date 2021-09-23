#!/bin/bash

declare sha1="kubectl.sha256"
declare FILE="kubectl"
declare FOLDER="./kubectl"
declare USER_NAME="cloudshell-user"
declare HOMEDIR="$(echo -n $(bash -c "cd ~${USER_NAME} && pwd"))"
declare LINE='export PATH=\$PATH:$HOMEDIR/bin'
declare FILE1='.bashrc'

SUDO=''
if (( $EUID != 0 )); then
    SUDO='sudo'
fi

curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl
curl -o kubectl.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl.sha256
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

$SUDO mv /tmp/eksctl $HOMEDIR/bin
chmod +x $FOLDER
mkdir -p $HOMEDIR/bin \
        && cp ./kubectl $HOMEDIR/bin/kubectl \
        && grep -qF "$LINE" "$FILE1"  || echo "$LINE" | sudo tee --append "$FILE1" \
        && source $HOMEDIR/.bashrc \
        && echo "Kubectl Version :" \
        && kubectl version --short --client \
        && echo "eksctl version :" \
		&& eksctl version

exit 0
