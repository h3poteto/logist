require 'rails/railtie'
require 'logist/logger'

module Logist
  class Railtie < Rails::Railtie
    config.lograge.formatter = Lograge::Formatters::Json.new
    config.lograge.custom_options = lambda do |event|
      {
        exception: event.payload[:exception], # ["ExceptionClass", "the message"]
        exception_object: event.payload[:exception_object] # the exception instance
      }
    end

    config.after_initialize do |app|
      Logist.setup(app) if Logist.enabled?(app)
      Lograge.setup(app) if Logist.enabled?(app)
    end
  end
end
