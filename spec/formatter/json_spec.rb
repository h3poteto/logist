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

  context "when flat_json=true" do
    before do
      formatter.flat_json = true
    end

    let(:deserialized_output) { JSON.parse(formatter.call("debug", now, "", message)) }

    context "when message is a hash" do
      let(:message) { { foo: "bar", xyz: "abc" } }

      it 'merges the message with the main hash' do
        expect(deserialized_output).to eq('level' => 'debug', 'environment' => Rails.env, 'timestamp' => now.strftime("%Y-%m-%dT%H:%M:%S.%6N "), 'foo' => 'bar', 'xyz' => 'abc')
      end
    end

    context "when message is something else" do
      let(:message) { 'Something else' }


      it "adds 'message' key to the main hash" do
        expect(deserialized_output).to eq('level' => 'debug', 'environment' => Rails.env, 'timestamp' => now.strftime("%Y-%m-%dT%H:%M:%S.%6N "), 'message' => 'Something else')
      end
    end
  end
end
