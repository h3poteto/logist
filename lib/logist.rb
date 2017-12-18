require "logist/version"
require 'logist/formatter/json'
require 'logist/logger'
require 'logger'
require 'lograge'

module Logist
  def self.setup(app)
    raise "You must configure logger to logist" if app.config.logger.nil? || app.config.logger.class != Logist::Logger
  end
end

require 'logist/railtie' if defined?(Rails)
