# Use the official image as a parent image
FROM rockylinux/rockylinux:8

# No need to install R from epel in Rocky Linux 8
RUN dnf install -y 'dnf-command(config-manager)' \
    && dnf config-manager --set-enabled powertools \
    && dnf install -y epel-release \
    && dnf install -y R \
    && dnf clean all

RUN R -e "install.packages(c('RHTML', 'rjson', 'DescTools', 'Rserve', 'haven'), repos='http://cran.us.r-project.org')"

COPY Rserv.conf /etc/Rserv.conf
COPY rserve-entrypoint.sh /rserve/docker-entrypoint.sh

CMD ["/rserve/docker-entrypoint.sh"]