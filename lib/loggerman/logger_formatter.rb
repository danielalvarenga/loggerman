require 'active_support/logger'

module Loggerman
	class LoggerFormatter < ActiveSupport::Logger::SimpleFormatter

		def call(severity, timestamp, progname, msg)
			log_message = Loggerman.formatter.format_log(severity, timestamp, progname, msg)
			"#{log_message}\n"
		end

	end
end