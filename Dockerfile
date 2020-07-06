FROM ruby:2.7.0
LABEL name="Parking_dev"
LABEL version=1.0

# Copy application code
COPY . /application
# Change to the application's directory
WORKDIR /application

RUN bundle install \
  && bundle exec rails db:create

EXPOSE 3000
ENTRYPOINT './entrypoint.sh'
