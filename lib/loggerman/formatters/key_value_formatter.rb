module Loggerman
	class Formatters::KeyValueFormatter < Formatters::Formatter

		def format_log(severity, timestamp, progname, message)
			log_result = "|#{severity}|time=#{timestamp.strftime("%Y-%m-%d %H:%M:%S")}|"
			log_result << "system=#{progname}|" unless progname.blank?
			log_result << "#{format_message(message)}" unless message.blank?
			log_result.to_s.gsub('||',"|")
		end

	  def convert_string(message)
	  	"details=#{message}|"
	  end

		def convert_hash(args)
			result = ""
	    args.each { |k,v| result << "#{k}=#{v.inspect}|" }
	    result.to_s
	  end

		def convert_exception(exception)
			message = "exception=#{exception.class}|message=#{exception.message}|"
			message << "#{format_message(exception.more_attributes)}|" if exception.respond_to?(:more_attributes) && !exception.more_attributes.blank?
			message << (exception.backtrace || []).join("\n")
			message.to_s
		end

	  def convert_string(message)
	  	"details=#{message.inspect}|"
	  end

	end
end