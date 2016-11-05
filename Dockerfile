FROM ruby:2.3

RUN apt-get update && apt-get install -y nodejs qt4-dev-tools libqt4-dev libqt4-core libqt4-gui xvfb mysql-client

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /opt/app
WORKDIR /opt/app

RUN RAILS_ENV=production bundle exec rake assets:precompile --trace

EXPOSE 80

CMD bash -c "bin/wait-db && bundle exec puma -C config/puma.rb"