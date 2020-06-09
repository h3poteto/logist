require 'active_support/logger_silence'
require 'active_support/logger_thread_safe_level'
require 'logger'

module Logist
  class Logger < ::Logger
    include ActiveSupport::LoggerThreadSafeLevel

    # https://github.com/rails/rails/pull/34045
    if defined?(ActiveSupport::LoggerSilence)
      include ActiveSupport::LoggerSilence
    else
      include LoggerSilence
    end

    def initialize(logdev, shift_age = 0, shift_size = 1048576, level: DEBUG,
                   progname: nil, formatter: nil, datetime_format: nil,
                   shift_period_suffix: '%Y%m%d')
      # I think that Logist should support other formats in the future.
      # But, as it is now, Logist only support json format.
      # So this line force json format all environments.
      @formatter = Logist::Formatter::Json.new
      @formatter.datetime_format = datetime_format
      super(logdev, shift_age, shift_size, level: level,
            progname: progname, formatter: @formatter, datetime_format: datetime_format,
            shift_period_suffix: shift_period_suffix)
      after_initialize if respond_to? :after_initialize
    end
  end
end
