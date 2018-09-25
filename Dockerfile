FROM openhab/openhab:2.3.0-armhf-debian

WORKDIR /openhab

COPY local/addons/  addons/
COPY local/conf/    conf/
COPY local/userdata userdata/
