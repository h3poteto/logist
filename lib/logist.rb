require "logist/version"
require 'logist/formatter/json'
require 'logist/logger'
require 'logger'
require 'lograge'

module Logist
  mattr_accessor :application
  def setup(app)
    self.application = application
    self.app.config.lograge.enabled = true
    self.app.config.lograge.formatter = Lograge::Formatters::Json.new
    self.app.config.lograge.custom_options = lambda do |event|
      {
        exception: event.payload[:exception], # ["ExceptionClass", "the message"]
        exception_object: event.payload[:exception_object] # the exception instance
      }
    end
  end
end

require 'logist/railtie' if defined?(Rails)
