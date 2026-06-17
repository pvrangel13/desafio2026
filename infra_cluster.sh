#! /bin/bash
# criação do cluster com kind
kind create cluster --name arkham --config cluster.yaml

# aguardando cluster finalizar
kubectl wait --for=condition=Ready nodes --all --timeout=300s

# aplicando manisfeto
kubectl apply -f manifests/


