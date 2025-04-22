#!/bin/bash
kubectl delete configmap webconfig fluentd-config fluentd-tomcat-config kibana-config tomcat-server-config tomcat-web-config elasticsearch-template --ignore-not-found=true
kubectl apply -f webconfig.yml,elasticsearch_template.yml,fluentd_config.yml,fluentd_tomcat_config.yml,kibana-config.yml,tomcat_server_config.yml,tomcat_web_config.yml
