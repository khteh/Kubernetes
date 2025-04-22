#!/bin/bash
#./restart_env.sh
kubectl scale sts aspnetcorewebapi --replicas=0
kubectl delete cm elasticsearch-template aspnetcore-fluentd-config appsettings-production appsettings-staging --ignore-not-found=true
kubectl delete secret aspnetcorewebapi email-credentials --ignore-not-found=true
kubectl delete sts aspnetcorewebapi
kubectl delete svc svc-{aspnetcorewebapi,aspnetcorewebapi-nodeport} --ignore-not-found=true
kubectl apply -f ../elasticsearch_template.yml,fluentd_config.yml,aspnetcorewebapi.postgresql.yml,appsettings.Production.yml,appsettings.Staging.yml,email_credentials.yml,svc-aspnetcorewebapi.yml,aspnetcorewebapi.yml
