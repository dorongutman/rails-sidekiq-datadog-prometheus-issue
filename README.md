# README

This repo shows a reproduction of an issue we have when trying to have the following three gems working together:
- sidekiq
- prometheus_exporter
- ddtrace (datadog's sdk)

First commit is a fresh `rails new` install
Second commit is the minimal changes needed to show this issue. Specifically, it has the additions of the three gems, and two initializer files:
- prometheus.rb for setting the middleware ([as instructed by the gem's installation guide](https://github.com/discourse/prometheus_exporter#rails-integration))
- sidekiq.rb for setting up prometheus specifically for sidekiq stuff ([as instructed by the prometheus gem docs for sidekiq](https://github.com/discourse/prometheus_exporter#sidekiq-metrics))

To run this repo and see sidekiq fails with `stack level too deep`:
- `bundle install`
- make sure you have a redis running locally
- in tab 1 run `bundle exec prometheus_exporter -v --bind 0.0.0.0 -p 9394` to run a server that the promethus exporter sends stuff to
- in tab 2 run `bundle exec sidekiq`


If you comment out the contents of `config/initializers/promethus.rb` sidekiq manages to run fine.
