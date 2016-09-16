module Loggerman
	module Formatters
		class Formatter

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
