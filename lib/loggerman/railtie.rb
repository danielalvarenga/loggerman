require 'rails/railtie'

module Loggerman
  class Railtie < Rails::Railtie
    config.loggerman = ActiveSupport::OrderedOptions.new
    config.loggerman.enabled = false

    config.after_initialize do |app|
      Loggerman.setup(app) if app.config.loggerman.enabled
    end
  end
end