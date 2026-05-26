#!/bin/bash
#./restart_env.sh
kubectl scale sts kern-subscriber --replicas=0
kubectl scale sts critical-subscriber --replicas=0
kubectl delete statefulset kern-subscriber critical-subscriber
#kubectl delete svc svc-kern-subscriber svc-critical-subscriber
#kubectl apply -f appsettings.Production.yml,svc-rabbitmqsubscriber.yml,rabbitmq-kern-subscriber.yml,rabbitmq-critical-subscriber.yml
kubectl apply -f appsettings.CriticalSubscriber.Production.yml,appsettings.KernSubscriber.Production.yml,rabbitmq-kern-subscriber.yml,rabbitmq-critical-subscriber.yml
