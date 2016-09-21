module Loggerman
  class Logger < Logger

    %w(info debug warn error fatal unknown).each do |level|
      class_eval <<-METHOD, __FILE__, __LINE__ + 1
        def #{level}(*args, &block)
          logger_by_level('#{level}').#{level}(*args, &block)
        end
      METHOD
    end

    def logger_by_level(level)
      @logger_by_level ||= {}
      return @logger_by_level[level] if @logger_by_level[level]
      @logger_by_level[level] ||= defined?(Rails) ? Rails.logger : nil
      unless Loggerman.log_files[level.to_sym].blank?
        file = Loggerman.log_files.fetch(level.to_sym)
        logfile = File.open(defined?(Rails) ? "#{Rails.root}/log/#{file}" : "log/#{file}", 'a')
        logfile.sync = true
        @logger_by_level[level] = ActiveSupport::Logger.new(logfile)
        @logger_by_level[level].formatter = Loggerman::LoggerFormatter.new
        @logger_by_level[level].level = Loggerman::level
        @logger_by_level[level].progname = Loggerman::progname
      end
      @logger_by_level[level]
    end
  end
end