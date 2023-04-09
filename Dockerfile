FROM ruby:2.6.6
RUN apt-get update -qq && \
	apt-get install -y build-essential nodejs npm 
	
RUN npm i -g yarn
COPY . ./home
WORKDIR /home
RUN bundle install
RUN yarn install
RUN bundle exec rake assets:precompile RAILS_ENV=production
RUN export RAILS_ENV=production
RUN rails db:migrate
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
EXPOSE 3000
