#!/usr/bin/env bash

kubectl create namespace pihole

helm repo add mojo2600 https://mojo2600.github.io/pihole-kubernetes/

helm repo update

helm upgrade \
  -n pihole \
  --install  \
  -f pihole-values.yml \
  pi mojo2600/pihole

kubectl delete service pi-pihole-tcp -n pihole