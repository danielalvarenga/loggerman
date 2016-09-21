require 'spec_helper'

describe Loggerman::Logger do
	context "log files by level" do

		let(:app_config) do
      double(config:
        ActiveSupport::OrderedOptions.new.tap do |config|
          config.loggerman = ActiveSupport::OrderedOptions.new
          config.loggerman.log_files = {
          	info: 'my_info_logs.log',
          	debug: 'my_debug_logs.log',
          	warn: 'my_warn_logs.log',
          	error: 'my_error_logs.log',
          	fatal: 'my_fatal_logs.log',
          	unknown: 'my_unknown_logs.log' }
        end
      )
    end

		it 'info' do
			Loggerman.setup(app_config)
			logger = Loggerman.logger.logger_by_level(:info)
			expect(logger).to be_is_a ActiveSupport::Logger
			expect(logger.inspect).to be_include "File:log/my_info_logs.log"
		end

		it 'debug' do
			Loggerman.setup(app_config)
			logger = Loggerman.logger.logger_by_level(:debug)
			expect(logger).to be_is_a ActiveSupport::Logger
			expect(logger.inspect).to be_include "File:log/my_debug_logs.log"
		end

		it 'warn' do
			Loggerman.setup(app_config)
			logger = Loggerman.logger.logger_by_level(:warn)
			expect(logger).to be_is_a ActiveSupport::Logger
			expect(logger.inspect).to be_include "File:log/my_warn_logs.log"
		end

		it 'error' do
			Loggerman.setup(app_config)
			logger = Loggerman.logger.logger_by_level(:error)
			expect(logger).to be_is_a ActiveSupport::Logger
			expect(logger.inspect).to be_include "File:log/my_error_logs.log"
		end

		it 'fatal' do
			Loggerman.setup(app_config)
			logger = Loggerman.logger.logger_by_level(:fatal)
			expect(logger).to be_is_a ActiveSupport::Logger
			expect(logger.inspect).to be_include "File:log/my_fatal_logs.log"
		end

		it 'unknown' do
			Loggerman.setup(app_config)
			logger = Loggerman.logger.logger_by_level(:unknown)
			expect(logger).to be_is_a ActiveSupport::Logger
			expect(logger.inspect).to be_include "File:log/my_unknown_logs.log"
		end

    it "set progname" do
      app_config.config.loggerman.progname = 'MySystem'
      Loggerman.setup(app_config)
      logger = Loggerman.logger.logger_by_level(:info)
      expect(logger.progname).to eq 'MySystem'
    end

    it "set level" do
      app_config.config.loggerman.level = :info
      Loggerman.setup(app_config)
      logger = Loggerman.logger.logger_by_level(:error)
      expect(logger.level).to eq 1
    end
	end
end