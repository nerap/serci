#!/bin/bash
SERVICE_LIST="telegraf metallb ftps nginx wordpress phpmyadmin grafana mysql influxdb"

function handler() { kill -9 $(ps aux | grep 'print.sh' | awk '{print $2}'); kill -9 $(ps aux | grep 'setup.sh' | awk '{print $2}'); minikube delete;  rm /tmp/tp ; clear; }
trap handler INT

touch /tmp/tp

bash srcs/setup/print.sh minikube &
./srcs/setup/start_minikube.sh
./srcs/setup/assign_ip.sh

kill -9 $(ps aux | grep 'print.sh' | awk '{print $2}');

bash srcs/setup/print.sh docker &

eval $(minikube docker-env)
printf "-->	Creating all images...\n" > /tmp/tp
for IMAGE in $SERVICE_LIST
do
	if [[ $IMAGE != 'metallb' ]]; then
		docker build -t $IMAGE:v1 srcs/containers/$IMAGE/ >> /tmp/tp
		printf "-->	Image $IMAGE successfully created !\n" >> /tmp/tp
	fi
done

kill -9 $(ps aux | grep 'print.sh' | awk '{print $2}');
bash srcs/setup/print.sh service &

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl create secret tls nginx --key srcs/containers/nginx/srcs/certs/server.key --cert srcs/containers/nginx/srcs/certs/server.crt

printf "-->	Creating all services...\n" >> /tmp/tp
for SERVICE in $SERVICE_LIST
do
	if [ $SERVICE != 'telegraph' ];then
		kubectl create -f srcs/$SERVICE.yaml >>  /tmp/tp
		printf "-->	Service $SERVICE successfully created !\n" >> /tmp/tp
	fi
done
sleep 10
screen -dmS t0 minikube dashboard

screen -dmS t1 ./srcs/setup_ftps.sh
screen -dmS t1 ./srcs/setup_wordpress.sh

kill -9 $(ps aux | grep 'print.sh' | awk '{print $2}');
rm /tmp/tp
clear
