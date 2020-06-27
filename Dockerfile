FROM ruby:2.6.6-alpine

# Prepare installs latest Chromium package.
# Reference: https://github.com/Zenika/alpine-chrome/blob/master/Dockerfile#L17
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/v3.11/main" >> /etc/apk/repositories 

RUN apk update && \
		apk add --no-cache \
			curl \
			curl-dev \
			nodejs \
			libstdc++ \
			libxml2-dev \
			libxslt-dev \
			linux-headers \
			mysql-client \
			mysql-dev \
			pcre \
			ruby-dev \
			ruby-json \
			tzdata \
			yaml \
			yaml-dev \
			bash \
			build-base \
			yarn \
			zlib-dev \
      udev \
      ttf-freefont \
      dpkg \
      chromium-chromedriver \
      chromium \
      su-exec

ENV TZ=Asia/Tokyo

ENV BUNDLER_VERSION 2.1.4
RUN gem uninstall bundler
RUN gem install bundler:$BUNDLER_VERSION

WORKDIR /usr/src/hockam

ARG RAILS_ENV
ENV RAILS_ENV ${RAILS_ENV:-development}
COPY Gemfile Gemfile.lock ./
RUN bundle config path vendor/bundle
RUN bundle config jobs 4
RUN bundle install
RUN apk del libxml2-dev curl-dev make gcc libc-dev g++

ARG NODE_ENV
ENV NODE_ENV ${NODE_ENV:-development}
COPY package.json yarn.lock ./
RUN yarn install
COPY . ./

# Add a script to be executed every time the container starts.
# See also https://docs.docker.com/compose/rails/
RUN rm -f /usr/src/hockam/tmp/pids/server.pid

# CMD ["bundle", "exec", "foreman", "start", "-f", "Procfile.development"]
