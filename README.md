# Loggerman

Loggerman format rails logs and add a custom logger to create log files by level.

Json format example:

```ruby
{"INFO":{"time":"2016-09-16 18:20:44","method":"logger_before","params":{"controller":"sessions","action":"new"}}}
```

Key_value format example:

```ruby
|INFO|time=2016-09-16 18:18:28|method="logger_before"|params={"controller"=>"sessions", "action"=>"new"}|
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'loggerman', git: 'https://github.com/danielalvarenga/loggerman.git', branch: 'master'
```

And then execute:

    $ bundle

Configure log formatter in environment:

```ruby
# config/environments/production.rb
config.log_formatter = Loggerman::LoggerFormatter.new
```

Customize format to :key_value (default) or :json :

```ruby
# config/initializers/loggerman.rb
MyApp::Application.configure do
  config.loggerman.format = :key_value
end
```

Customize log files by level (rails log file is default):

```ruby
# config/initializers/loggerman.rb
MyApp::Application.configure do
  config.loggerman.log_files = { error: 'my_error_logs.log', warn: 'other_file.log' }
end
```

## Usage

```ruby
Loggerman.info 'any string'
Loggerman.warn key1: 'value1', key2: 'value2'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/danielalvarenga/loggerman.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

