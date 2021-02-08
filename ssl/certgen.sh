#!/bin/sh

# Script to generate a CSR
# Also generatea a local certificate (no CA) for testing purposes
# See sample config file server.cfg for inputs
# rehanj@etherzine.com

[ -z $1 ] && echo "\nusage: `basename $0` <config_file>\n" && exit 1

CONFIG_FILE=$1
if [ ! -r $1 ]; then
	echo
	echo "Unable to find config file: $CONFIG_FILE"
	echo
	exit 1
fi

# Generate Key
openssl req -new -nodes -out server.csr -keyout rui-orig.key -config $CONFIG_FILE

# Remove Private Key Passphrase
openssl rsa -in rui-orig.key -out rui.key
rm rui-orig.key

# Check csr:
openssl req -text -noout -in server.csr > certcheck.txt 2>&1
echo "\n- Certificate Check file csrcheck.txt written\n"

# Generate Certificate
openssl x509 -req -sha256 -days 365 -extfile $CONFIG_FILE -extensions v3_req -in server.csr -signkey rui.key -out server.cer

echo "\n- Certificate Request: \"server.csr\" created"
echo "\n Certificate \"server.cer\" generated"


