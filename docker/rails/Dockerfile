FROM ruby:2.2-slim

RUN apt-get update -qq && apt-get install -y mysql-client libmysqlclient-dev make gcc g++
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
