#!/bin/bash
kubectl apply -f https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml
#kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.20.2/cert-manager.yaml Installed as microk8s addon
kubectl apply -f https://github.com/rabbitmq/messaging-topology-operator/releases/latest/download/messaging-topology-operator-with-certmanager.yaml
kubectl apply -f rabbitmq_tls_cert.yml,rabbitmq_users_permissions.yml,rabbitmq_vhosts.yml,rabbitmq_users.yml,rabbitmq_bindings.yml,rabbitmq_exchange.yml,rabbitmq_queue.yml,rabbitmq-cluster.yml,rabbitmq-pod-disruption-budget.yml