# phusion/baseimage as FROM image.
FROM phusion/baseimage:0.11
MAINTAINER Rob White <"r0bth3g33k@gmail.com">

CMD ["/sbin/my_init"]

RUN DEBIAN_FRONTEND=noninteractive &&

# Install libasound2 so we can have audio from cameras.
RUN apt-get update && apt-get -y upgrade && apt-get install -y libasound2

# Download and configure the latest release
 RUN curl -o /root/xeoma_linux64.tgz http://felenasoft.com/xeoma/downloads/xeoma_linux64.tgz
 RUN tar -zxvf /root/xeoma_linux64.tgz -C /root
 RUN /root/xeoma.app -install -coreauto
 RUN rm /root/xeoma_linux64.tgz
 RUN touch /root/firstrun

# Set xeoma password to P@ssword
 RUN /root/xeoma.app -setpassword 'P@ssword'
 RUN /root/xeoma.app -showpassword

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
