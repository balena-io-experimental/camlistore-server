
## ToDo: have option to pull in config from remote server
## `-configfile https://url.to/config`

cd ${HOME}/.config/camlistore/
cp server-config.json.template server-config.json
# Update defaults
sed -i "s/%CAMLISTORE_AUTH%/${CAMLISTORE_AUTH-none}/" server-config.json

# Initialize database
/bin/camtool dbinit

# Run Camlistore
/bin/camlistored
