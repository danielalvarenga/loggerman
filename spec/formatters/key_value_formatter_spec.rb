require 'spec_helper'

describe Loggerman::Formatters::KeyValueFormatter do

	let(:severity) { 'INFO' }
	let(:progname) { 'MySystem' }
	let(:timestamp) { Time.new(2016, 9, 20, 13, 43, 52) }

	subject { Loggerman::Formatters::KeyValueFormatter.new }

	context 'log format' do
		it 'when string' do
			message = 'In my code something happens'
			formatted_message = subject.format_log(severity, timestamp, progname, message)
			# puts formatted_message
			expect(formatted_message).to eq "2016-09-20 13:43:52|INFO|src=127.0.0.1|host=de-sp-d07|system=MySystem|details=In my code something happens|"
		end

		it 'when hash' do
			message = { key01: 'value 01', key02: 'value02', key03: { key031: 'value031', key032: 'value032' } }
			formatted_message = subject.format_log(severity, timestamp, progname, message)
			# puts formatted_message
			expect(formatted_message).to eq "2016-09-20 13:43:52|INFO|src=127.0.0.1|host=de-sp-d07|system=MySystem|key01=\"value 01\"|key02=\"value02\"|key03={:key031=>\"value031\", :key032=>\"value032\"}|"
		end

		it 'when exception' do
			begin
				{}.fetch(:anything)
			rescue Exception => e
				message = e
				formatted_message = subject.format_log('ERROR', timestamp, progname, message)
				# puts formatted_message
				expect(formatted_message).to be_starts_with "2016-09-20 13:43:52|ERROR|src=127.0.0.1|host=de-sp-d07|system=MySystem|exception=KeyError|message=key not found: :anything|location=/home/dev/dev/ruby-projects/loggerman/spec/formatters/key_value_formatter_spec.rb"
			end
		end

		it 'when other' do
			message = Loggerman::Logger
			formatted_message = subject.format_log(severity, timestamp, progname, message)
			# puts formatted_message
			expect(formatted_message).to eq "2016-09-20 13:43:52|INFO|src=127.0.0.1|host=de-sp-d07|system=MySystem|details=Loggerman::Logger|"
		end
	end
end