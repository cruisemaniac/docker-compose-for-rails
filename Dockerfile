FROM ruby:2.4.2-alpine3.6

RUN apk --update add nodejs netcat-openbsd postgresql-dev libxml2-dev libxslt-dev build-base
RUN apk --update add --virtual linux-headers build-dependencies make g++

RUN mkdir /myapp

WORKDIR /myapp

ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock

RUN bundle install
# RUN apk del build-dependencies
RUN rm -rf /var/cache/apk/*

ADD . /myapp

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]
