require 'spec_helper'

describe Loggerman do
  it 'has a version number' do
    expect(Loggerman::VERSION).not_to be nil
  end

  context 'setup' do

    let(:app_config) do
      double(config:
              ActiveSupport::OrderedOptions.new.tap do |config|
                config.loggerman = ActiveSupport::OrderedOptions.new
                config.loggerman.log_files = { error: 'my_error_logs.log' }
              end
            )
    end

    it "not set format" do
      Loggerman.setup(app_config)
      expect(Loggerman.formatter).to be_is_a Loggerman::Formatters::KeyValueFormatter
    end

    it "set json format" do
    	app_config.config.loggerman.format = :json
      Loggerman.setup(app_config)
      expect(Loggerman.formatter).to be_is_a Loggerman::Formatters::JsonFormatter
    end

    it "set key_value format" do
    	app_config.config.loggerman.format = :key_value
      Loggerman.setup(app_config)
      expect(Loggerman.formatter).to be_is_a Loggerman::Formatters::KeyValueFormatter
    end

    it "custom error log file" do
      Loggerman.setup(app_config)
      expect(Loggerman.log_files).to eq({ error: 'my_error_logs.log' })
    end

    it "set logger" do
      Loggerman.setup(app_config)
      expect(Loggerman.logger).to be_is_a Loggerman::Logger
    end
  end
end
