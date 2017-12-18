require 'json'
require 'logger'
require 'rails'

module Logist
  module Formatter
    class Json < ::Logger::Formatter
      def call(severity, timestamp, progname, msg)
        begin
          j = ::JSON.parse(msg)
          temp = {level: severity, timestamp: format_datetime(timestamp), environment: ::Rails.env}.merge(j)
          ::JSON.dump(temp) + "\n"
        rescue JSON::ParserError
          "{\"level\":\"#{severity}\",\"timestamp\":\"#{format_datetime(timestamp)}\",\"message\":\"#{msg}\",\"environment\":\"#{::Rails.env}\"}\n"
        end
      end
    end
  end
end
