# Development environment

FROM ruby:2.2-slim as development

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

EXPOSE 3000

CMD ["bin/rake", "db:migrate", "RAILS_ENV=development"]

# Production environment

FROM development as production

CMD ["RAILS_ENV=production", "bundle", "exec", "rake", "assets:precompile"]
CMD ["RAILS_ENV=production", "bundle", "exec", "rake", "db:migrate"]
