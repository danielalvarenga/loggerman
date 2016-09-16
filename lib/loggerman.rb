require "loggerman/version"
require 'loggerman/railtie' if defined?(Rails)
require 'loggerman/logger_formatter'
require 'loggerman/logger'
require 'loggerman/formatters/formatter'
require 'loggerman/formatters/json_formatter'
require 'loggerman/formatters/key_value_formatter'

module Loggerman
  module_function
	mattr_accessor :logger, :application, :formatters, :format, :log_files

  def setup(app)
  	self.application = app
  	set_formatters
  	set_format
  	set_log_files
  	set_logger
  end

  def set_formatters
  	Loggerman.formatters = {json: Loggerman::Formatters::JsonFormatter.new, key_value: Loggerman::Formatters::KeyValueFormatter.new}
  end

  def set_format
  	Loggerman.format = loggerman_config.format || :key_value
  end

  def set_log_files
  	Loggerman.log_files = loggerman_config.log_files || {}
  end

  def set_logger
  	Loggerman.logger = Loggerman::Logger.new("#{Rails.root}/log/#{Rails.env.to_s}.log")
  end

  def loggerman_config
    application.config.loggerman
  end

end
