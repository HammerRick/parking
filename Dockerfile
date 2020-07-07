FROM ruby:2.7.0
LABEL name="Parking_dev"
LABEL version=1.0

# Copy application code
COPY . /parking
# Change to the application's directory
WORKDIR /parking

RUN bundle install \
  && bundle exec rails db:create

EXPOSE 3000
ENTRYPOINT './entrypoint.sh'
