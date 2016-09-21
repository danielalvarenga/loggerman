module Loggerman
	module Formatters
		class KeyValueFormatter < Formatter

			def format_log(severity, timestamp, progname, message)
				log_result = "#{timestamp.strftime("%Y-%m-%d %H:%M:%S")}|#{severity}|src=#{Socket.ip_address_list[0].ip_address}|host=#{Socket.gethostname}|"
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
				message << "location=#{exception.backtrace_locations.first}|" unless exception.backtrace_locations.blank?
				message << "#{format_message(exception.more_attributes)}|" if exception.respond_to?(:more_attributes) && !exception.more_attributes.blank?
				message << "\n#{(exception.backtrace).join("\n")}" unless exception.backtrace.empty?
				message.to_s
			end

		  def convert_other(message)
		  	"details=#{message.inspect}|"
		  end

		end
	end
end