#!/bin/sh

# Set default hostname
if ! [ -z "$c2hostname" ]; then
    c2hostname="-hostname $c2hostname"
else
    c2hostname="-hostname $(hostname -f)"
fi

# Set Database
if ! [ -z "$c2db" ]; then
    c2db="-db $c2db"
else
    c2db="-db /hak5/data/c2.db"
fi

# Set HTTPS Settings
if ! [ -z "$c2https" ]; then
    c2https="-https"
fi

if ! [ -z "$c2certFile" ]; then
    c2certFile="-certFile $c2certFile"
fi

if ! [ -z "$c2keyFile" ]; then
    c2keyFile="-keyFile $c2keyFile"
fi

# Set Listing IP and Port settings
if ! [ -z "$c2listenip" ]; then
    c2listenip="-listenip $c2listenip"
fi

if ! [ -z "$c2listenport" ]; then
    c2listenport="-listenport $c2listenport"
fi

# Set reverse proxy settings
if ! [ -z "$c2reverseProxy" ]; then
    c2reverseProxy="-reverseProxy"
fi

if ! [ -z "$c2reverseProxyPort" ]; then
    c2reverseProxyPort="-reverseProxyPort $c2reverseProxyPort"
fi

# Set SSH Settings
if ! [ -z "$c2sshport" ]; then
    c2sshport="-sshport $c2sshport"
fi

# Set License Settings
if ! [ -z "$c2licedition" ]; then
    c2licedition="-setEdition $c2licedition"
fi

if ! [ -z "$c2lickey" ]; then
    c2lickey="-setLicenseKey $c2lickey"
fi

# NoBanner setting -nobanner

if ! [ -z "$c2nobanner" ]; then
    c2nobanner="-nobanner"
fi

# Start application and note the settings used
echo "Starting with:" $c2hostname $c2certFile $c2db $c2https $c2keyFile $c2listenip $c2listenport $c2reverseProxy $c2reverseProxyPort $c2sshport

/hak5/c2-latest $c2hostname $c2certFile $c2db $c2https $c2keyFile $c2listenip $c2listenport $c2reverseProxy $c2reverseProxyPort $c2sshport $c2licedition $c2lickey $c2nobanner
