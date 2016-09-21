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

    it "default format" do
      Loggerman.setup(app_config)
      expect(Loggerman.formatter).to be_is_a Loggerman::Formatters::KeyValueFormatter
    end

    it "default level" do
      Loggerman.setup(app_config)
      expect(Loggerman.level).to eq 0
    end

    it "default progname" do
      Loggerman.setup(app_config)
      expect(Loggerman.progname).to eq nil
    end

    it "set debug level" do
      app_config.config.loggerman.level = :debug
      Loggerman.setup(app_config)
      expect(Loggerman.level).to eq 0
    end

    it "set info level" do
      app_config.config.loggerman.level = :info
      Loggerman.setup(app_config)
      expect(Loggerman.level).to eq 1
    end

    it "set warn level" do
      app_config.config.loggerman.level = :warn
      Loggerman.setup(app_config)
      expect(Loggerman.level).to eq 2
    end

    it "set error level" do
      app_config.config.loggerman.level = :error
      Loggerman.setup(app_config)
      expect(Loggerman.level).to eq 3
    end

    it "set fatal level" do
      app_config.config.loggerman.level = :fatal
      Loggerman.setup(app_config)
      expect(Loggerman.level).to eq 4
    end

    it "set unknown level" do
      app_config.config.loggerman.level = :unknown
      Loggerman.setup(app_config)
      expect(Loggerman.level).to eq 5
    end

    it "set progname" do
      app_config.config.loggerman.progname = 'MySystem'
      Loggerman.setup(app_config)
      expect(Loggerman.progname).to eq 'MySystem'
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
