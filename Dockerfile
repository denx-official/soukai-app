# Development environment

FROM ruby:2.2-slim as development

ENV RAILS_ENV=production

RUN apt-get update -qq && apt-get install -y sqlite3 libsqlite3-dev make gcc g++
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

RUN ["bundle", "exec", "rake", "assets:precompile"]
RUN ["bundle", "exec", "rake", "db:migrate"]

# Production environment

FROM development as production

CMD bundle exec rails server -b '0.0.0.0' -p ${PORT:-3000} -e production
