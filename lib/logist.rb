require "logist/version"
require 'logist/formatter/json'
require 'logist/logger'
require 'logger'
require 'lograge'

module Logist
  def self.setup(app)
    raise Logist::LoggerError, "You must configure logger to logist" unless enabled?(app)
  end

  def self.enabled?(app)
    !app.config.logger.nil? && app.config.logger.class == Logist::Logger
  end
end

class Logist::LoggerError < StandardError; end

require 'logist/railtie' if defined?(Rails)
