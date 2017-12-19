require 'spec_helper'

RSpec.describe Logist::Formatter::Json do
  let(:formatter) { Logist::Formatter::Json.new }
  let(:now) { Time.now }

  context "message is a string" do
    let(:deserialized_output) { JSON.parse(formatter.call("debug", now, "", "test message")) }
    it do
      expect(deserialized_output).to eq('level' => 'debug', 'environment' => Rails.env, 'timestamp' => now.strftime("%Y-%m-%dT%H:%M:%S.%6N "), 'message' => 'test message')
    end
  end

  context "message is a json string" do
    let(:deserialized_output) { JSON.parse(formatter.call("debug", now, "", "{\"hoge\":\"fuga\"}")) }
    it do
      expect(deserialized_output).to eq('level' => 'debug', 'environment' => Rails.env, 'timestamp' => now.strftime("%Y-%m-%dT%H:%M:%S.%6N "), 'hoge' => 'fuga')
    end
  end
end
