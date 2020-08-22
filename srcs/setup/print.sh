while [ 1 ];do
	for n in 11 22 33 44;do
		for i in 0, 1, 2, 3;do
			clear
			head -n $n ./srcs/setup/$1_ascii | tail -n 11
			tail -n $((`tput lines` - 11)) /tmp/tp
			sleep 0.25
		done
	done
done
