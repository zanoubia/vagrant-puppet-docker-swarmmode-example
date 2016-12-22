FROM ruby:2.2.5
RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y libpq-dev
RUN mkdir /guestbook
WORKDIR /guestbook
ADD guestbook/Gemfile /guestbook/Gemfile
ADD guestbook/Gemfile.lock /guestbook/Gemfile.lock
RUN bundle install
ADD guestbook /guestbook
CMD bundle exec rackup -s Puma

