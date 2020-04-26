FROM ruby:2.7.1
RUN mkdir /simpleDNS
WORKDIR /simpleDNS
COPY Gemfile /simpleDNS/Gemfile
COPY Gemfile.lock /simpleDNS/Gemfile.lock

RUN bundle install

COPY . /simpleDNS