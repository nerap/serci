if [[ $(minikube status | grep -c "Running") == 0 ]];then
	minikube start --vm-driver="docker" --cpus=2 --memory=5000m > /tmp/tp
	minikube addons enable dashboard >> /tmp/tp
	minikube addons enable metallb >> /tmp/tp
fi
