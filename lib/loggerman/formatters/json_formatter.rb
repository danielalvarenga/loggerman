module Loggerman
	class Formatters::JsonFormatter < Formatters::Formatter

		def format_log(severity, timestamp, progname, message)
			log_result = { severity => { time: timestamp.strftime("%Y-%m-%d %H:%M:%S") } }
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
			result = { class: exception.class, message: exception.message, location: exception.backtrace_locations.try(:first) }
			result.merge!( format_message(exception.more_attributes) ) if exception.respond_to? :more_attributes && !exception.more_attributes.blank?
			result.merge!( { backtrace: exception.backtrace } )
		end

	  def convert_string(message)
	  	{ details: message.inspect }
	  end

	end
end