#!/bin/bash
#./restart_env.sh
kubectl scale sts kern-subscriber --replicas=0
kubectl scale sts critical-subscriber --replicas=0
kubectl delete statefulset kern-subscriber critical-subscriber
kubectl apply -f appsettings.CriticalSubscriber.Production.yml,appsettings.KernSubscriber.Production.yml,subscriber_fluentd_config.yml,rabbitmq-kern-subscriber.yml,rabbitmq-critical-subscriber.yml
