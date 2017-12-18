# Logist

This gem provides json format for logger in Rails. Logist output json log like this:

```
$ bundle exec rails s -b 0.0.0.0
=> Booting Puma
=> Rails 5.1.4 application starting in development
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.10.0 (ruby 2.4.2-p198), codename: Russell's Teapot
* Min threads: 1, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop
{"level":"INFO","timestamp":"2017-12-18T08:55:19+00:00","message":"hoge","environment":"development"}
{"level":"INFO","timestamp":"2017-12-18T08:55:19+00:00","environment":"development","method":"GET","path":"/api/health_check","format":"html","controller":"Api::HealthCheckController","action":"index","status":200,"duration":1.89,"view":0.81,"db":0.0,"exception":null,"exception_object":null}
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'logist'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install logist

## Usage

You have to use logist logger in your `config/evnrionments/[rails-env].rb`:

```ruby
Rails.application.configure do
  # ...
  config.logger = Logist::Logger.new(STDOUT)
end
```

You can change logger configuration like this:

```ruby
Rails.application.configure do
  # ...
  config.logger = Logist::Logger.new(STDOUT, datetime_format: "%Y-%m-%dT%H:%M:%S%:z:")
end
```

or

```ruby
Rails.application.configure do
  # ...
  config.logger = Logist::Logger.new(STDOUT)
  config.logger.formatter.datetime_format = "%Y-%m-%dT%H:%M:%S%:z"
end
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/h3poteto/logist. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Logist project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/logist/blob/master/CODE_OF_CONDUCT.md).
