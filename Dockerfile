FROM ruby:3.1.3-alpine

ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

RUN mkdir /myapp
WORKDIR /myapp

RUN apk add --no-cache alpine-sdk \
  build-base \
  postgresql-dev \
  postgresql-client \
  tzdata \
  musl-dev \
  bash \
  vim

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN gem install bundler
RUN bundle install
COPY . /myapp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
