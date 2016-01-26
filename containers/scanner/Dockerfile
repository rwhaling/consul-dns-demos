FROM java:8u40-jdk
WORKDIR /root/

RUN curl -s get.sdkman.io | bash
RUN ["/bin/bash", "-c", "source /root/.sdkman/bin/sdkman-init.sh"]
RUN echo "sdkman_suggestive_selfupdate=false" >> /root/.sdkman/etc/config
RUN ["/bin/bash", "-c", "-l", "sdk install springboot"]

ENV PATH /root/.sdkman/candidates/springboot/current/bin:$PATH
ENV DNS_BASE service.consul
ENV WORLD_NAME "discovered world"
ADD Scanner.groovy Scanner.groovy
ENTRYPOINT ["spring", "run", "Scanner.groovy"]
EXPOSE 8080
