#!/bin/bash

# [ "$1" != '' ] &&
# [[ -z "$1" ]]

if [[ "$1" == '' ]]; then
    echo "No cluster-name Argument Provided"
    echo "CreateEKScluster.sh myCluster"
    echo "CreateEKScluster.sh delete myCluster"
    exit 1
elif [[ "$1" != '' ]]; then
    arg=$1
    if [[ "${arg,,}" == "d" || "${arg,,}" == "delete" ]]
    then
        echo "Attempting to delete ${2}"
        # eksctl delete cluster --name ${2} --region us-west-2
        exit 1
    else
        echo "Standin for create Cluster and check cluster health here"
        # eksctl create cluster \
        # --name "${arg,,}" \
        # --region us-west-2 \
        # --fargate && \
        # kubectl get svc && \
        # kubectl get nodes -o wide && \
        # kubectl get pods --all-namespaces -o wide
    fi
fi

exit 0
