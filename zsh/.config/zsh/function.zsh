
mc () {
	mkdir -p -- "$1" && cd -P -- "$1"
}

hostip () {
	export HOST_IP="$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}' | head -n 1)" 
	echo $HOST_IP
}

pxio () {
	export https_proxy=http://10.10.43.3:1080
	export http_proxy=http://10.10.43.3:1080
	export all_proxy=socks5://10.10.43.3:1081
	echo "set proxy to 10.10.43.3:1080"
}

px () {
	export https_proxy=http://127.0.0.1:1080
	export http_proxy=http://127.0.0.1:1080
	export all_proxy=socks5://127.0.0.1:1081
	echo "set proxy to 127.0.0.1:1080"
}


nopx () {
	export https_proxy=
	export http_proxy=
	export all_proxy=
	echo "set proxy to nil"
}


# auto set proxy
setpx () {
	ping -c 1 -q 10.10.43.3 1> /dev/null; ping1=$?
	if [ $ping1 -eq 0 ]
	then
		pxio
	else
		px
	fi
}
