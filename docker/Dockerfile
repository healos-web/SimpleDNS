FROM ruby:2.7.1
RUN git clone https://github.com/healos-web/simpleDNS.git
WORKDIR /simpleDNS

RUN gem install bundler
RUN bundle install

COPY .env /simpleDNS/config/