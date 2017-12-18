require "logist/version"
require 'logist/formatter'
require 'logger'

module Logist
  class Logger < ::Logger
    def initialize(logdev, shift_age = 0, shift_size = 1048576, level: DEBUG,
                 progname: nil, formatter: nil, datetime_format: nil,
                 shift_period_suffix: '%Y%m%d')
      @formatter = Logist::Formatter::Json.new
      @formatter.datetime_format = datetime_format
      super(logdev, shift_age, shift_size, level: level,
            progname: progname, formatter: @formatter, datetime_format: datetime_format,
            shift_period_suffix: shift_period_suffix)
    end
  end
end

require 'logist/railtie' if defined?(Rails)
