# Loggerman

Loggerman format rails logs and add a custom logger to create log files by level.

Json format example:

```ruby
{"INFO":{"time":"2016-09-20 13:43:52","src":"127.0.0.1","host":"de-sp-d07","system":"MySystem","details":"In my code something happens"}}
{"INFO":{"time":"2016-09-20 13:43:52","src":"127.0.0.1","host":"de-sp-d07","system":"MySystem","key01":"value 01","key02":"value02","key03":{"key031":"value031","key032":"value032"}}}
{"INFO":{"time":"2016-09-20 13:43:52","src":"127.0.0.1","host":"de-sp-d07","system":"MySystem","details":"Loggerman::Logger"}}
{"ERROR":{"time":"2016-09-20 13:43:52","src":"127.0.0.1","host":"de-sp-d07","system":"MySystem","exception":{"class":"KeyError","message":"key not found: :anything","location":{},"backtrace":["/home/dev/dev/ruby-projects/loggerman/spec/formatters/json_formatter_spec.rb:28:in `fetch'","/home/dev/dev/ruby-projects/loggerman/spec/formatters/json_formatter_spec.rb:28:in `block (3 levels) in \u003ctop (required)\u003e'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example.rb:254:in `instance_exec'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example.rb:254:in `block in run'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example.rb:496:in `block in with_around_and_singleton_context_hooks'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example.rb:453:in `block in with_around_example_hooks'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/hooks.rb:471:in `block in run'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/hooks.rb:609:in `run_around_example_hooks_for'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/hooks.rb:471:in `run'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example.rb:453:in `with_around_example_hooks'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example.rb:496:in `with_around_and_singleton_context_hooks'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example.rb:251:in `run'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example_group.rb:627:in `block in run_examples'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example_group.rb:623:in `map'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example_group.rb:623:in `run_examples'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example_group.rb:589:in `run'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example_group.rb:590:in `block in run'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example_group.rb:590:in `map'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example_group.rb:590:in `run'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:113:in `block (3 levels) in run_specs'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:113:in `map'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:113:in `block (2 levels) in run_specs'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/configuration.rb:1836:in `with_suite_hooks'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:112:in `block in run_specs'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/reporter.rb:77:in `report'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:111:in `run_specs'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:87:in `run'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:71:in `run'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:45:in `invoke'","/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/exe/rspec:4:in `\u003ctop (required)\u003e'","/home/dev/.rvm/gems/ruby-2.3.1/bin/rspec:23:in `load'","/home/dev/.rvm/gems/ruby-2.3.1/bin/rspec:23:in `\u003cmain\u003e'","/home/dev/.rvm/gems/ruby-2.3.1/bin/ruby_executable_hooks:15:in `eval'","/home/dev/.rvm/gems/ruby-2.3.1/bin/ruby_executable_hooks:15:in `\u003cmain\u003e'"]}}}
```

Key_value format example:

```ruby
2016-09-20 13:43:52|INFO|src=127.0.0.1|host=de-sp-d07|system=MySystem|details=In my code something happens|
2016-09-20 13:43:52|INFO|src=127.0.0.1|host=de-sp-d07|system=MySystem|key01="value 01"|key02="value02"|key03={:key031=>"value031", :key032=>"value032"}|
2016-09-20 13:43:52|INFO|src=127.0.0.1|host=de-sp-d07|system=MySystem|details=Loggerman::Logger|
2016-09-20 13:43:52|ERROR|src=127.0.0.1|host=de-sp-d07|system=MySystem|exception=KeyError|message=key not found: :anything|location=/home/dev/dev/ruby-projects/loggerman/spec/formatters/key_value_formatter_spec.rb:28:in `fetch'|
/home/dev/dev/ruby-projects/loggerman/spec/formatters/key_value_formatter_spec.rb:28:in `fetch'
/home/dev/dev/ruby-projects/loggerman/spec/formatters/key_value_formatter_spec.rb:28:in `block (3 levels) in <top (required)>'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example.rb:254:in `instance_exec'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example.rb:254:in `block in run'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example.rb:496:in `block in with_around_and_singleton_context_hooks'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example.rb:453:in `block in with_around_example_hooks'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/hooks.rb:471:in `block in run'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/hooks.rb:609:in `run_around_example_hooks_for'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/hooks.rb:471:in `run'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example.rb:453:in `with_around_example_hooks'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example.rb:496:in `with_around_and_singleton_context_hooks'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example.rb:251:in `run'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example_group.rb:627:in `block in run_examples'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example_group.rb:623:in `map'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example_group.rb:623:in `run_examples'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example_group.rb:589:in `run'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example_group.rb:590:in `block in run'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example_group.rb:590:in `map'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/example_group.rb:590:in `run'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:113:in `block (3 levels) in run_specs'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:113:in `map'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:113:in `block (2 levels) in run_specs'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/configuration.rb:1836:in `with_suite_hooks'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:112:in `block in run_specs'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/reporter.rb:77:in `report'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:111:in `run_specs'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:87:in `run'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:71:in `run'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/lib/rspec/core/runner.rb:45:in `invoke'
/home/dev/.rvm/gems/ruby-2.3.1/gems/rspec-core-3.5.2/exe/rspec:4:in `<top (required)>'
/home/dev/.rvm/gems/ruby-2.3.1/bin/rspec:23:in `load'
/home/dev/.rvm/gems/ruby-2.3.1/bin/rspec:23:in `<main>'
/home/dev/.rvm/gems/ruby-2.3.1/bin/ruby_executable_hooks:15:in `eval'
/home/dev/.rvm/gems/ruby-2.3.1/bin/ruby_executable_hooks:15:in `<main>'
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'loggerman', '~> 0.1.0'
```

And then execute:

    $ bundle

Configure log formatter in environment if you prefer to apply format to rails default log:

```ruby
# config/environments/production.rb
config.log_formatter = Loggerman::LoggerFormatter.new
```

Customize log level for loggerman (rails log level is default) :

```ruby
# config/initializers/loggerman.rb
MyApp::Application.configure do
  config.loggerman.level = :info
end
```

Customize format (default is :key_value):

```ruby
# config/initializers/loggerman.rb
MyApp::Application.configure do
  config.loggerman.format = :key_value # or :json
end
```

Customize log files by level (rails log file is default):

```ruby
# config/initializers/loggerman.rb
MyApp::Application.configure do
  config.loggerman.log_files = { error: 'my_error_logs.log', warn: 'other_file.log' }
end
```

Customize progname (rails log progname is default) :

```ruby
# config/initializers/loggerman.rb
MyApp::Application.configure do
  config.loggerman.progname = 'MySystem'
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

