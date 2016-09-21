require 'spec_helper'

describe Loggerman::Formatters::JsonFormatter do

	let(:severity) { 'INFO' }
	let(:progname) { 'MySystem' }
	let(:timestamp) { Time.new(2016, 9, 20, 13, 43, 52) }

	subject { Loggerman::Formatters::JsonFormatter.new }

	context 'format log' do
		it 'when string' do
			message = 'In my code something happens'
			formatted_message = subject.format_log(severity, timestamp, progname, message)
			# puts formatted_message
			expect(formatted_message).to eq "{\"INFO\":{\"time\":\"2016-09-20 13:43:52\",\"src\":\"127.0.0.1\",\"host\":\"de-sp-d07\",\"system\":\"MySystem\",\"details\":\"In my code something happens\"}}"
		end

		it 'when hash' do
			message = { key01: 'value 01', key02: 'value02', key03: { key031: 'value031', key032: 'value032' } }
			formatted_message = subject.format_log(severity, timestamp, progname, message)
			# puts formatted_message
			expect(formatted_message).to eq "{\"INFO\":{\"time\":\"2016-09-20 13:43:52\",\"src\":\"127.0.0.1\",\"host\":\"de-sp-d07\",\"system\":\"MySystem\",\"key01\":\"value 01\",\"key02\":\"value02\",\"key03\":{\"key031\":\"value031\",\"key032\":\"value032\"}}}"
		end

		it 'when exception' do
			begin
				{}.fetch(:anything)
			rescue Exception => e
				message = e
				formatted_message = subject.format_log(severity, timestamp, progname, message)
				# puts formatted_message
				message_result = JSON.parse(formatted_message)
				expect(message_result['INFO']['exception']['class']).to eq 'KeyError'
				expect(message_result['INFO']['exception']['message']).to eq 'key not found: :anything'
				expect(message_result['INFO']['exception']['backtrace']).not_to be_empty
			end
		end

		it 'when other' do
			message = Loggerman::Logger
			formatted_message = subject.format_log(severity, timestamp, progname, message)
			# puts formatted_message
			expect(formatted_message).to eq "{\"INFO\":{\"time\":\"2016-09-20 13:43:52\",\"src\":\"127.0.0.1\",\"host\":\"de-sp-d07\",\"system\":\"MySystem\",\"details\":\"Loggerman::Logger\"}}"
		end
	end
end