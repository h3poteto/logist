require 'rails/railtie'
require 'lograge'

module Logist
  class Railtie < Rails::Railtie
    config.lograge.enabled = true
    config.lograge.formatter = Lograge::Formatters::Json.new
    config.lograge.custom_options = lambda do |event|
      {
        exception: event.payload[:exception], # ["ExceptionClass", "the message"]
        exception_object: event.payload[:exception_object] # the exception instance
      }
    end
  end
end
