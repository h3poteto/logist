require 'json'
require 'logger'
require 'rails'

module Logist
  module Formatter
    class Json < ::Logger::Formatter
      def call(severity, timestamp, progname, msg)
        { level: severity, timestamp: format_datetime(timestamp), environment: ::Rails.env, message: format_message(msg) }.to_json + "\n"
      end

      def format_message(msg)
        if msg.is_a?(Hash) || msg.is_a?(Array) || msg.is_a?(StandardError)
          msg
        else
          begin
            JSON.parse(msg)
          rescue JSON::ParserError
            "#{msg}"
          end
        end
      end
    end
  end
end
