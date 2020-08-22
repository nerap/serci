#!/bin/bash
SERVICE_LIST="metallb ftps nginx wordpress phpmyadmin grafana"
for SERVICE in $SERVICE_LIST
do
	kubectl delete -f srcs/$SERVICE.yaml
	echo "-->	Service $SERVICE successfully deleted !\n"
done
sleep 2
for SERVICE in $SERVICE_LIST
do
	kubectl create -f srcs/$SERVICE.yaml
	echo "-->	Service $SERVICE successfully created !\n"
done
