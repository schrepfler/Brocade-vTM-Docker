FROM andyfurnival/centos:master

MAINTAINER Andy Furnival

ENV VTM_VERSION 104

COPY zinstall.txt /tmp/
# COPY ZeusTM_104_Linux-x86_64.tgz /tmp/

RUN cd /tmp/  \
     && yum install -y net-tools \
     && yum install -y which \
     && echo "Downloading VTM Installer... Please wait..."  \
     && wget "http://www.badpenguin.co.uk/vadc/ZeusTM_${VTM_VERSION}_Linux-x86_64.tgz" \
     && echo "Running VTM Installer... Please wait..."   \
     && tar -xf ZeusTM_${VTM_VERSION}_Linux-x86_64.tgz  \
     && chmod +x /tmp/Zeus*/zinstall \
     && /tmp/Zeus*/zinstall --replay-from=/tmp/zinstall.txt --noninteractive  \
     && rm -rf /tmp/*  \
     && yum clean all -y

COPY zconfig.txt runzeus.sh /usr/local/zeus/

ENV ZEUSHOME=/usr/local/zeus
# set the livement mode to developer
ENV ZEUS_DEVMODE=true
# ZEUS_EULA must be set to "accept" otherwise the container will do nothing
ENV ZEUS_EULA=

# ZEUS_LIC can be used to pass a URL from which the container will download a license file
ENV ZEUS_LIC=

# ZEUS_PASS can be used to set a password. By default a password will be generated for you
# ZEUS_PASS=[RANDOM|SIMPLE]: generate a random pass, ZEUS_PASS=STRONG to employ more symbols.
# Or ZEUS_PASS=<your password>
ENV ZEUS_PASS=RANDOM

# ZEUS_DOM can be used to set a domain and ensure the host has a FQDN.
ENV ZEUS_DOM=

# ZEUS_PACKAGES can be used to install additional packages on first run.
# If you need Java Extensions.... Eg ZEUS_PACKAGES="openjdk-7-jre-headless"
ENV ZEUS_PACKAGES=
CMD [ "/usr/local/zeus/runzeus.sh" ]
EXPOSE 9070 9080 9090 9090/udp 80 443
