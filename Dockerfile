FROM registry.access.redhat.com/ubi8/ubi-init
LABEL nextdns.version="nextdns-v1.37.4"

RUN curl -Ls https://repo.nextdns.io/nextdns.repo -o /etc/yum.repos.d/nextdns.repo; \
    yum -y install --disableplugin=subscription-manager -y nextdns; \
#    yum -y install --disableplugin=subscription-manager -y bind-utils ; \
    yum  --disableplugin=subscription-manager clean all; \
    rm -rf /var/cache/yum; \
    setcap 'cap_net_bind_service=+ep' /usr/bin/nextdns

EXPOSE 53/tcp 53/udp
ENTRYPOINT ["/usr/bin/nextdns","run", "-config-file", "/etc/nextdns.conf"]