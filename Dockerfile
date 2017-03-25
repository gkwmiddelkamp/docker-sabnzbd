FROM lsiobase/xenial
MAINTAINER sparklyballs

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config" \
PYTHONIOENCODING=utf-8

# install packages
RUN \
 echo "deb http://ppa.launchpad.net/jcfp/ppa/ubuntu xenial main" >> /etc/apt/sources.list.d/sabnzbd.list && \
 echo "deb-src http://ppa.launchpad.net/jcfp/ppa/ubuntu xenial main" >> /etc/apt/sources.list.d/sabnzbd.list && \
 echo "deb http://ppa.launchpad.net/jcfp/sab-addons/ubuntu xenial main" >> /etc/apt/sources.list.d/sabnzbd.list && \
 echo "deb-src http://ppa.launchpad.net/jcfp/sab-addons/ubuntu xenial main" >> /etc/apt/sources.list.d/sabnzbd.list && \
 apt-key adv --keyserver hkp://keyserver.ubuntu.com:11371 --recv-keys 0x98703123E0F52B2BE16D586EF13930B14BB9F05F && \
 apt-get update && \
 apt-get install -y \
	libtbb2 \
	p7zip-full \
	python-sabyenc \
	sabnzbdplus \
	unrar \
	unzip && \

# install par2 multithreaded
 apt-get remove -y \
	par2 && \
 apt-get install -y \
	par2-tbb && \

# cleanup
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8080 9090
VOLUME /config /downloads /incomplete-downloads
