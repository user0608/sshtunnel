
if [ "$REMOTE" != "true" ]; then
	/usr/bin/autossh \
		-vv \
		-o StrictHostKeyChecking=no \
		-o UserKnownHostsFile=/dev/null \
		-Nn $TUNNEL_HOST \
		-p $TUNNEL_PORT \
		-L *:$LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT \
		-i $KEY
else
	/usr/bin/autossh \
		-vv \
		-o StrictHostKeyChecking=no \
		-o UserKnownHostsFile=/dev/null \
		-Nn $TUNNEL_HOST \
		-p $TUNNEL_PORT \
		-R 0.0.0.0:$REMOTE_PORT:$CONTAINER_HOST:$CONTAINER_PORT \
		-i $KEY
fi

echo "Exiting ..."
sleep 5
