require "loggerman/version"
require 'loggerman/railtie' if defined?(Rails)
require 'loggerman/logger_formatter'
require 'loggerman/logger'
require 'loggerman/formatters/formatter'
require 'loggerman/formatters/json_formatter'
require 'loggerman/formatters/key_value_formatter'

module Loggerman
  module_function
	mattr_accessor :logger, :application, :formatters, :formatter, :log_files, :level, :progname

  def setup(app)
    self.application = app
    set_level
    set_progname
  	set_formatters
  	set_formatter
  	set_log_files
  	set_logger
  end

  def set_level
    Loggerman.level = [:debug, :info, :warn, :error, :fatal, :unknown].index( loggerman_config.level )
    Loggerman.level ||= defined?(Rails) ? Rails.logger.level : 0
  end

  def set_progname
    Loggerman.progname = loggerman_config.progname
    Loggerman.progname ||= defined?(Rails) ? Rails.logger.progname : nil
  end

  def set_formatters
    Loggerman.formatters = {json: Loggerman::Formatters::JsonFormatter.new, key_value: Loggerman::Formatters::KeyValueFormatter.new}
  end

  def set_formatter
  	Loggerman.formatter = Loggerman.formatters.fetch( loggerman_config.format || :key_value )
  end

  def set_log_files
  	Loggerman.log_files = loggerman_config.log_files || {}
  end

  def set_logger
  	Loggerman.logger = Loggerman::Logger.new(defined?(Rails) ? "#{Rails.root}/log/#{Rails.env.to_s}.log" : 'log/loggerman.log')
    Loggerman.logger.level = Loggerman.level
    Loggerman.logger.progname = Loggerman.progname

  end

  def loggerman_config
    application.config.loggerman
  end

  %w(info debug warn error fatal unknown).each do |level|
    define_method level.to_sym do |*args, &block|
      Loggerman.logger.send(level.to_sym, *args, &block)
    end
  end

end
