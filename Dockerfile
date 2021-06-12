ARG RUBY_VERSION
FROM ruby:${RUBY_VERSION}-buster

RUN set -eux; \
  apt update; \
  apt install -y --no-install-recommends \
    git \
    subversion \
    \
    libpq-dev \
    *libmysqlclient-dev \
  ; \
  rm -rf /var/lib/apt/lists/*

WORKDIR /redmine
ARG REDMINE_SVN_PATH
RUN svn checkout http://svn.redmine.org/redmine/${REDMINE_SVN_PATH} /redmine

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 3000
CMD [ "bash" ]
