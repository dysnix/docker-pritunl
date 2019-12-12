FROM debian:buster-slim

ARG DEBIAN_FRONTEND=noninteractive
RUN \
  apt-get -y update && apt-get -y install curl gnupg iptables procps netcat && \
  ## Install the latest version of Pritunl \
  ## \
  echo "deb http://repo.pritunl.com/stable/apt buster main" > /etc/apt/sources.list.d/pritunl.list && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A && \
  apt-get -y update && apt-get -y install pritunl && \
  ## \
  ## Use legacy iptables not (nf_tables) \
  update-alternatives --set iptables /usr/sbin/iptables-legacy && \
  ## \
  ## cleanup \
  apt-get -y purge curl gnupg && apt-get -y autoremove && rm -rf /var/lib/apt/lists

COPY entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["/usr/bin/pritunl", "start"]
