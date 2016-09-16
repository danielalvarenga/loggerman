require 'rails/railtie'

module Loggerman
  class Railtie < Rails::Railtie
    config.loggerman = ActiveSupport::OrderedOptions.new
    config.loggerman.enabled = false

    config.after_initialize do |app|
    	if app.config.loggerman.enabled
	      Loggerman.setup(app)
	      LOGGERMAN = Loggerman.logger
	    end
    end
  end
end