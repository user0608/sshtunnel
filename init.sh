#!/bin/sh
if [ -z "$AUTOSSH_PORT"]; then
	export AUTOSSH_PORT=0
fi
if [ -f "$KEY" ];then
	cp $KEY /ssh_key
	chmod 400 /ssh_key	
fi

if [ -z "$TUNNEL_HOST" ]
then
	echo "the env var TUNNEL_HOST need to be set to the name/ip of the remote ssh host"
	exit 1
fi


echo "Starting ssh tunnel"
if [ "$REMOTE" != "true" ]; then
	if [ -z "$LOCAL_PORT" ]
	then
		echo "the env var LOCAL_PORT need to be set to the port on which this container will listen to"
		exit 1
	fi
	if [ -z "$REMOTE_HOST" ]
	then
		echo "the env var REMOTE_HOST need to be set to the host the tunnel will be forwarded to"
		exit 1
	fi
	if [ -z "$REMOTE_PORT" ]
	then
		echo "the env var REMOTE_PORT need to be set to the port on the REMOTE_HOST the tunnel will be forwarded to"
		exit 1
	fi
	/usr/bin/autossh \
		$SSHLOGLEVEL -F $SSHCONFIGFILE \
		-Nn $TUNNEL_HOST \
		-p $TUNNEL_PORT \
		-L *:$LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT \
		-i /ssh_key \
		-F $SSHCONFIGFILE
else
	if [ -z "$REMOTE_PORT" ]
	then
		echo "the env var REMOTE_PORT need to be set to the port on which this tunnel will listen on the TUNNEL_HOST"
		exit 1
	fi
	if [ -z "$CONTAINER_HOST" ]
	then
		echo "the env var CONTAINER_HOST need to be set to the host the tunnel REMOTE_PORT will be forwarded to"
		exit 1
	fi
	if [ -z "$CONTAINER_PORT" ]
	then
		echo "the env var CONTAINER_PORT need to be set to the port on the REMOTE_PORT the tunnel will be forwarded to"
		exit 1
	fi
	/usr/bin/autossh \
		$SSHLOGLEVEL -F $SSHCONFIGFILE \
		-Nn $TUNNEL_HOST \
		-p $TUNNEL_PORT \
		-R 0.0.0.0:$REMOTE_PORT:$CONTAINER_HOST:$CONTAINER_PORT \
		-i /ssh_key 
fi

echo "Exiting ..."
sleep 5
