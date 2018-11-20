FROM ubuntu:18.04

# Initialize Apt repo.
RUN set -xe && \
	apt-get update

# Install mysqldump.
RUN set -xe && \
	apt-get install -y mysql-client

# Install AWS tools.
RUN set -xe && \
	apt-get install -y python2.7 curl && \
	curl -O https://bootstrap.pypa.io/get-pip.py && \
	python2.7 get-pip.py && \
	pip install awscli --upgrade

# clean up local apt repo.
RUN set -xe && \
	apt-get clean all

COPY docker-entrypoint.sh /

ENTRYPOINT /docker-entrypoint.sh
