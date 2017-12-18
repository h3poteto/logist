require 'rails/railtie'
require 'logist/options'

module Logist
  class Railtie < Rails::Railtie
    config.logist = Logist::Options.new
    config.logist.enabled = false
    config.lograge.formatter = Lograge::Formatters::Json.new
    config.lograge.custom_options = lambda do |event|
      {
        exception: event.payload[:exception], # ["ExceptionClass", "the message"]
        exception_object: event.payload[:exception_object] # the exception instance
      }
    end

    config.after_initialize do |app|
      Logist.setup(app) if app.config.logist.enabled
      Lograge.setup(app) if app.config.logist.enabled
    end
  end
end
