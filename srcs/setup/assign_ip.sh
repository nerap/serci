IP=`docker inspect minikube --format="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"`
head -n $((`wc srcs/metallb.yaml | cut -d ' ' -f2` - 1)) srcs/metallb.yaml > /tmp/tm
echo "           - $IP-`echo $IP | cut -d "." -f1-3 | tr -d "\n"`.100" >> /tmp/tm; cp /tmp/tm srcs/metallb.yaml; rm /tmp/tm
