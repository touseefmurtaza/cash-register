FROM ruby:3.1

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install
# Copy the rest of the application code into the container
COPY . .

# run test cases
CMD ["rspec"]
