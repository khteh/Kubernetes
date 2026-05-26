#!/bin/bash
kubectl delete job rabbitmq-publisher-job --ignore-not-found=true
kubectl apply -f appsettings.Publisher.Production.yml,rabbitmq-publisher.yml
