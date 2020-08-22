echo "Waiting for Address before launch wordpress"
while true
do
	if [ `kubectl exec deploy/wordpress -- grep -H "REPLACEME" /www/wp-config.php` ]
	then
		IPWP=`kubectl get services/wordpress -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
		while [ $IPWP = '<none>' ]
		do
			sleep 1
			IPWP=`kubectl get services/wordpress -o=custom-columns='ADDRESS:status.loadBalancer.ingress[0].ip'|tail -n1`
		done

		kubectl exec deploy/wordpress -- sed -ie "s/REPLACEME/$IPWP/g" /www/wp-config.php
		break
	fi
	sleep 10
done
