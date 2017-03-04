FROM gcr.io/google_containers/ubuntu-slim:0.4

RUN apt-get update
RUN apt-get install -y -q --no-install-recommends \
                        curl ca-certificates make g++ sudo bash

RUN ulimit -n 65536
ENV DEBIAN_FRONTEND noninteractive
ENV LD_PRELOAD /opt/td-agent/embedded/lib/libjemalloc.so
ADD conf/fluent.conf /etc/td-agent/td-agent.conf
                     
RUN /usr/bin/curl -sSL https://toolbelt.treasuredata.com/sh/install-ubuntu-xenial-td-agent2.sh | sh
RUN sed -i -e "s/USER=td-agent/USER=root/" -e "s/GROUP=td-agent/GROUP=root/" /etc/init.d/td-agent

RUN ["td-agent-gem", "install", "fluent-plugin-elasticsearch", "--no-rdoc", "--no-ri", "--version", "1.9.2"]
RUN ["td-agent-gem", "install", "fluent-plugin-record-reformer", "--no-rdoc", "--no-ri", "--version", "0.9.0"]    

RUN rm -rf /opt/td-agent/embedded/share/doc \
                /opt/td-agent/embedded/share/gtk-doc \
                /opt/td-agent/embedded/lib/postgresql \
                /opt/td-agent/embedded/bin/postgres \
                /opt/td-agent/embedded/share/postgresql

RUN apt-get remove -y
RUN apt-get autoremove -y
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

ENTRYPOINT ["td-agent"]