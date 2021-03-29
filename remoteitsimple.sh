
#!/bin/sh

DEVKEY="YOUR REMOTE.IT DEVKEY"
USERNAME="YOUR USERNAME"
PASSWORD="YOUR PASSWORD"
DEVICE_ADDRESS="DEVICE ADDRESS"
HOSTIP="HOST IP"

response=$(curl -X POST -H developerkey:"$DEVKEY" -H Content-Type:application/json -H Cache-Control:no-cache -d "{ \"username\":\"$USERNAME\", \"password\":\"$PASSWORD\" }" https://api.remot3.it/apv/v27/user/login | ./jq --raw-output '.auth_token' )


TOKEN=$response
#echo $TOKEN


catmanprox=$(curl -X POST \
     -H "token:$TOKEN" \
     -H "developerkey:$DEVKEY" \
     -d "{\"wait\":\"true\",\"deviceaddress\":\"$DEVICE_ADDRESS\", \
          \"hostip\":\"$HOSTIP\" }" \
     https://api.remot3.it/apv/v27/device/connect | ./jq --raw-output '.connection.proxy' )

echo $catmanprox | awk -F "//" {print '$2'}
