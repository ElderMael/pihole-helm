#!/usr/bin/env bash

set -ex

kubectl create namespace pihole || true
kubectl create namespace prometheus || true

helm repo add mojo2600 https://mojo2600.github.io/pihole-kubernetes/
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable

helm repo update

helm upgrade \
  -n pihole \
  --install  \
  -f pihole.values.yml \
  hole mojo2600/pihole \
  --set adminPassword="${PIHOLE_ADMIN_PASSWORD}"

helm upgrade \
  -n prometheus \
  --install  \
  -f prometheus.values.yml \
  co2 prometheus-community/prometheus