FROM java:8u40-jdk
WORKDIR /root/

RUN curl -s get.sdkman.io | bash
RUN ["/bin/bash", "-c", "source /root/.sdkman/bin/sdkman-init.sh"]
RUN echo "sdkman_suggestive_selfupdate=false" >> /root/.sdkman/etc/config
RUN ["/bin/bash", "-c", "-l", "sdk install groovy"]

# Fix path
RUN ["ls","-a","/root/.sdkman"]
ENV GROOVY_HOME /root/.sdkman/candidates/groovy/current
ENV PATH $GROOVY_HOME/bin:$PATH
ADD dnsScan.groovy dnsScan.groovy
RUN ["groovy", "dnsScan.groovy"]
ENTRYPOINT ["groovy", "dnsScan.groovy"]
CMD ["redis.service.consul"]
