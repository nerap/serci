echo "Waiting for Address before launch wordpress"
while true
do
	IPWP=`kubectl get services/wordpress -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
	while [ $IPWP = '<none>' ]
	do
		sleep 1
		IPWP=`kubectl get services/wordpress -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
	done
	kubectl exec deploy/wordpress -- sed -ie "s/REPLACEME/$IPWP/g" /www/wp-config.php
	sleep 10
done
