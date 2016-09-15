module Loggerman
	class LoggerFormatter < ActiveSupport::Logger::SimpleFormatter

		def call(severity, timestamp, progname, msg)
			@formatter ||= Loggerman.formatters.fetch(Loggerman.format)
			log_message = @formatter.format_log(severity, timestamp, progname, msg)
			"#{log_message}\n"
		end

	end
end