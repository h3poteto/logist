require 'json'
require 'logger'
require 'rails'

module Logist
  module Formatter
    class Json < ::Logger::Formatter
      def call(severity, timestamp, progname, msg)
        logobj = {level: severity, timestamp: format_datetime(timestamp), environment: ::Rails.env}
        begin
          msg = ::JSON.parse(msg)
          logobj.merge!(msg)
        rescue JSON::ParserError
          logobj[:message] = msg
        end
        ::JSON.dump(logobj) + "\n"
      end
    end
  end
end
