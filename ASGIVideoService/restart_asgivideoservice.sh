#!/bin/bash
kubectl scale sts asgivideoservice --replicas=0
kubectl delete statefulset asgivideoservice --ignore-not-found=true
#kubectl delete svc svc-{asgivideoservice,asgivideoservice-nodeport} --ignore-not-found=true
kubectl delete cm elasticsearch-template hypercorn-config asgivideoservice asgivideoservice-fluentd-config --ignore-not-found=true
kubectl apply -f ../elasticsearch_template.yml,hypercorn_config.yml,asgivideoservice_config.yml,fluentd_config.yml,svc-asgivideoservice.yml,asgivideoservice.yml
