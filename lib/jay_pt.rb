require "dotenv/load"

require_relative "jay_pt/agent"
require_relative "jay_pt/cve"

RubyLLM.configure do |config|
  config.openai_api_key = ENV["OPENAI_API_KEY"]
end

module JayPT
  class Error < StandardError; end
end
