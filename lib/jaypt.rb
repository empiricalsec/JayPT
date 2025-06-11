require "dotenv/load"

require_relative "jaypt/agent"
require_relative "jaypt/cve"

RubyLLM.configure do |config|
  config.openrouter_api_key = ENV["OPENROUTER_API_KEY"]
end

module JayPT
  class Error < StandardError; end
end
