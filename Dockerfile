FROM ruby:2.6.6
RUN apt-get update -qq && \
	apt-get install -y build-essential postgresql nodejs npm 
	
RUN npm i -g yarn
COPY . ./home
WORKDIR /home
RUN bundle install
RUN yarn install
RUN bundle exec rake assets:precompile RAILS_ENV=development
RUN export RAILS_ENV=development
RUN export secret_key_base=60e13c3d4bf990b33d43fef3a5bce0fbd1b900a9e32740d4ac036190d280eb767b278441e95e2fb8ea3ca85e9b0c0b950d82bef282832e4c1bfb3d027260fb
RUN rails db:migrate
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
EXPOSE 3000
