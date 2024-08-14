FROM ubuntu:22.04

# install openjdk-17
RUN apt-get update \
    && apt install -y openjdk-17-jre openjdk-17-jdk \
    && apt-get clean

# install imagemagick, jq, postgresql-client, curl, wget, zip, unzip, python3, python3-pip
RUN apt-get update \
    && apt install -y imagemagick jq postgresql-client curl wget zip unzip less netcat vim \
    && apt install -y python3 python3-pip \
    && apt-get clean

# install python packages
COPY static/requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt \
    && rm -rf /root/.cache/pip /tmp/requirements.txt

# TODO: no need to install but mount to the container as volume
COPY download/counter-processor-0.1.04.tar.gz /tmp/counter-processor.tar.gz
RUN cd /usr/local \
    && tar -xvf /tmp/counter-processor.tar.gz

COPY download/payara-6.2024.6.zip /tmp/payara.zip
RUN useradd -m dataverse \
    && cd /usr/local \
    && unzip /tmp/payara.zip \
    && chown -R root:root /usr/local/payara6 \
    && chown dataverse /usr/local/payara6/glassfish/lib \
    && chown -R dataverse:dataverse /usr/local/payara6/glassfish/domains/domain1

#
# don't change above commands unless necessary
COPY static/dataverse-entrypoint.sh /scripts/dataverse-entrypoint.sh
CMD ["/scripts/dataverse-entrypoint.sh"]

