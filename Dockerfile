# phusion/baseimage as FROM image.
FROM phusion/baseimage
MAINTAINER Rob White <"r0bth3g33k@gmail.com">

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND=noninteractive

# Speed up APT
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
  && echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Install libasound2 so we can have audio from cameras.
RUN apt-get update && apt-get -y upgrade && apt-get install -y libasound2

# Download and configure the latest release
 RUN curl -o /root/xeoma_linux64.tgz http://felenasoft.com/xeoma/downloads/xeoma_linux64.tgz
 RUN tar -zxvf /root/xeoma_linux64.tgz -C /root
 RUN /root/xeoma.app -install -hiddenmode
 RUN rm /root/xeoma_linux64.tgz
 RUN touch /root/firstrun

# Set xeoma password to P@ssword and start
 RUN /root/xeoma.app -setpassword 'P@ssword'
 RUN /root/bin/Xeoma/xeoma -showpassword
 RUN /root/bin/Xeoma/xeoma -- -service -log -startdelay 5

# Set up start up scripts
# RUN mkdir -p /etc/service/xeoma/run
# RUN curl -o /etc/service/xeoma/run/xeoma.sh https://raw.githubusercontent.com/r0bth3g33k/rtg-xeoma/master/xeoma.sh
# RUN chmod +x /etc/service/xeoma/run

 VOLUME /usr/local/Xeoma

# Clean up APT when done.
 RUN apt-get clean
 RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose Xeomas remote access port. 
 EXPOSE 8090
 EXPOSE 10090
