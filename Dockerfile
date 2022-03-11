FROM registry.access.redhat.com/ubi8/ubi-init
LABEL nextdns.build.version="v1.37.10"
#LABEL quay.expires-after=3w

RUN curl -Ls https://repo.nextdns.io/nextdns.repo -o /etc/yum.repos.d/nextdns.repo; \
    yum -y install --disableplugin=subscription-manager -y nextdns; \
#    yum -y install --disableplugin=subscription-manager -y bind-utils ; \
    yum  --disableplugin=subscription-manager clean all; \
    rm -rf /var/cache/yum; \
    setcap 'cap_net_bind_service=+ep' /usr/bin/nextdns

EXPOSE 53/tcp 53/udp
ENTRYPOINT ["/usr/bin/nextdns","run", "-config-file", "/etc/nextdns.conf"]
