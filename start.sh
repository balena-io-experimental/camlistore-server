
## ToDo: have option to pull in config from remote server
## `-configfile https://url.to/config`

CAMLICONFIG="${HOME}/.config/camlistore/server-config.json"
echo "Config file: $CAMLICONFIG"

### First time run with timeout
if [ ! -f "${CAMLICONFIG}" ]
then
    echo "First time setup, running with 60s timeout generate config"
    timeout -t 60 camlistored
fi

# Update config file
cat ${CAMLICONFIG} | jq "(.auth=\"${CAMLISTORE_AUTH-localhost}\") | \
                         (.baseURL=\"${CAMLISTORE_BASEURL-https://${RESIN_DEVICE_UUID}.resindevice.io}\") | \
                         (.listen=\":80\") | \
                         (.runIndex=true)" > "${CAMLICONFIG}.tmp"
mv "${CAMLICONFIG}.tmp" "${CAMLICONFIG}"

# Run camlistore server
/bin/camlistored
