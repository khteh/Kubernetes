#!/bin/bash
kubectl scale sts ollama --replicas=0
kubectl delete cm elasticsearch-template ollama-fluentd-config ollama-config --ignore-not-found=true
kubectl delete sts ollama
#kubectl delete pvc -l app=ollama Takes a long time to download 42GB llama3.3 model!
#kubectl delete svc svc-{ollama,ollama-nodeport} --ignore-not-found=true
kubectl apply -f ../elasticsearch_template.yml,fluentd_config.yml,ollama_config.yml,svc-ollama.yml,ollama.yml
