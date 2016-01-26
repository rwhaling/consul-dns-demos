FROM ubuntu:latest
RUN apt-get -y install dnsutils
RUN apt-get -y install curl
ADD scan.sh /usr/bin/scan.sh
RUN chmod +x /usr/bin/scan.sh
CMD /usr/bin/scan.sh
