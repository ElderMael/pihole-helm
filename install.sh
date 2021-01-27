#!/usr/bin/env bash

set -ex

kubectl create namespace pihole || true
kubectl create namespace monitoring || true
kubectl create namespace ovpn || true

helm repo add mojo2600 https://mojo2600.github.io/pihole-kubernetes/
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add suda https://suda.github.io/charts/

helm repo update

helm upgrade \
  -n pihole \
  --install  \
  -f pihole.values.yml \
  hole mojo2600/pihole \
  --set adminPassword="${PIHOLE_ADMIN_PASSWORD}"

kubectl -n monitoring apply -f dashboards/co2.yml

helm upgrade \
  -n monitoring \
  --install  \
  -f monitoring.values.yml \
  co2 prometheus-community/kube-prometheus-stack

#helm upgrade \
#  -n ovpn \
#  --install  \
#  -f vpn.values.yml \
#  openvpn suda/personal-ovpn \
#  --version 0.2.1
