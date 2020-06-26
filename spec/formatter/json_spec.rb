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

  context "message is a string with double quotes" do
    let(:deserialized_output) { JSON.parse(formatter.call("debug", now, "", "test :message with \"quotes\"")) }
    it do
      expect(deserialized_output).to eq('level' => 'debug', 'environment' => Rails.env, 'timestamp' => now.strftime("%Y-%m-%dT%H:%M:%S.%6N "), 'message' => 'test :message with "quotes"')
    end
  end

  context "message is a json string" do
    let(:deserialized_output) { JSON.parse(formatter.call("debug", now, "", "{\"hoge\":\"fuga\"}")) }
    it do
      expect(deserialized_output).to eq('level' => 'debug', 'environment' => Rails.env, 'timestamp' => now.strftime("%Y-%m-%dT%H:%M:%S.%6N "), 'message' => {'hoge' => 'fuga'})
    end
  end

  context "message is a hash" do
    let(:deserialized_output) { JSON.parse(formatter.call("debug", now, "", {k: "1", b: 2})) }
    it do
      expect(deserialized_output).to eq('level' => 'debug', 'environment' => Rails.env, 'timestamp' => now.strftime("%Y-%m-%dT%H:%M:%S.%6N "), 'message' => { 'k' => '1', "b" => 2 })
    end
  end

  context "message is a array" do
    let(:deserialized_output) { JSON.parse(formatter.call("debug", now, "", [{hoge: "fuga"}])) }
    it do
      expect(deserialized_output).to eq('level' => 'debug', 'environment' => Rails.env, 'timestamp' => now.strftime("%Y-%m-%dT%H:%M:%S.%6N "), "message"=>[{"hoge"=>"fuga"}])
    end
  end

  context "message is a StandardError" do
    let(:deserialized_output) { JSON.parse(formatter.call("debug", now, "", StandardError.new("hoge"))) }
    it do
      expect(deserialized_output).to eq('level' => 'debug', 'environment' => Rails.env, 'timestamp' => now.strftime("%Y-%m-%dT%H:%M:%S.%6N "), "message"=> "hoge")
    end
  end
end
