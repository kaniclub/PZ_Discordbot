FROM ruby:2.6.5

ENV APP_HOME /home/source

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
ADD ./source ./

RUN apt-get update -y && apt-get install -y libsodium-dev

RUN bundle install

CMD ["bundle", "exec", "ruby", "bot.rb"]