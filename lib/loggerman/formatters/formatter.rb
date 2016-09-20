module Loggerman
	module Formatters
		class Formatter

			def format_log(severity, timestamp, progname, message) ; raise NotImplementedError end
			def convert_string(message) ; raise NotImplementedError end
			def convert_hash(args) ; raise NotImplementedError end
			def convert_exception(exception) ; raise NotImplementedError end
			def convert_other(message) ; raise NotImplementedError end

			def clean_message(message)
				if message.is_a?(String)
					message = message.strip.gsub(/\e\[(\d+)m/, '')
					message = eval(message)
				end
				message
			rescue Exception => e
				message
			end 

			def format_message(message)
				message = clean_message(message)
				case message
		    when ::String
		      convert_string(message)
		    when ::Hash
		      convert_hash(message)
		    when ::Exception
		      convert_exception(message)
		    else
		    	convert_other(message)
		    end
		  end

		end
	end
end
