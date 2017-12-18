require 'rails/railtie'
require 'logist/options'

module Logist
  class Railtie < Rails::Railtie
    config.logist = Logist::Options.new
    config.logist.enabled = false

    config.after_initialize do |app|
      Lograge.setup(app) if app.config.logist.enabled
    end
  end
end
