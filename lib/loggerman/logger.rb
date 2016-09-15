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
      @logger_by_level[level] ||= Rails.logger
      unless Loggerman.log_files[level.to_sym].blank?
        file = Loggerman.log_files.fetch(level.to_sym)
        logfile = File.open("#{Rails.root}/log/#{file}", 'a')
        logfile.sync = true
        @logger_by_level[level] = ::Logger.new(logfile)
        @logger_by_level[level].formatter = Loggerman::LoggerFormatter.new
      end
      @logger_by_level[level]
    end
  end
end