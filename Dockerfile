# 针对腾讯云 Serverless 构建。
FROM ruby:2.7.6

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.3.14
RUN bundle install

COPY . .

EXPOSE 9000

CMD ["ruby", "app.rb"]
