FROM ruby:3.0.4

WORKDIR /ibc-api

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client libvips

COPY Gemfile /ibc-api/Gemfile
COPY Gemfile.lock /ibc-api/Gemfile.lock

RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
