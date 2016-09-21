module Loggerman
	module Formatters
		class JsonFormatter < Formatter

			def format_log(severity, timestamp, progname, message)
				log_result = { severity => { time: timestamp.strftime("%Y-%m-%d %H:%M:%S"), src: Socket.ip_address_list[0].ip_address, host: Socket.gethostname } }
				log_result[severity].merge!( {system: progname.to_s} ) unless progname.blank?
				log_result[severity].merge!( format_message(message) ) unless message.blank?
				log_result.to_json
			end

		  def convert_string(message)
		  	{ details: message }
		  end

			def convert_hash(args)
				args
		  end

			def convert_exception(exception)
				result = { exception: { class: exception.class.to_s, message: exception.message, location: exception.backtrace_locations.try(:first) } }
				result[:exception].merge!( { location: exception.backtrace_locations.first } ) unless exception.backtrace_locations.blank?
				result[:exception].merge!( format_message(exception.more_attributes) ) if exception.respond_to?(:more_attributes) && !exception.more_attributes.blank?
				result[:exception].merge!( { backtrace: exception.backtrace } ) unless exception.backtrace.blank?
				result
			end

		  def convert_other(message)
		  	{ details: message.inspect }
		  end

		end
	end
end