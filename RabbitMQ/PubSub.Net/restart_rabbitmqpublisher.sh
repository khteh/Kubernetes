#!/bin/bash
kubectl delete cronjob rabbitmq-publisher-job --ignore-not-found=true
kubectl apply -f appsettings.Publisher.Production.yml,publisher_fluentd_config.yml,rabbitmq-publisher.yml
