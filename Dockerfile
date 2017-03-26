FROM ruby:2.3

RUN apt-get update && apt-get install -y nodejs qt4-dev-tools libqt4-dev libqt4-core libqt4-gui xvfb mysql-client

RUN curl --output /usr/local/bin/phantomjs https://s3.amazonaws.com/circle-downloads/phantomjs-2.1.1
RUN chmod +x /usr/local/bin/phantomjs

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /opt/app
WORKDIR /opt/app

RUN chmod -R +x bin

RUN RAILS_ENV=production bundle exec rake assets:precompile --trace

EXPOSE 80

RUN apt-get install -y vim

CMD bash -c "bin/setup && bundle exec puma -C config/puma.rb"