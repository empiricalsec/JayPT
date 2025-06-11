require "dotenv/load"

require_relative "jay_pt/agent"
require_relative "jay_pt/cve"

RubyLLM.configure do |config|
  config.openrouter_api_key = ENV["OPENROUTER_API_KEY"]
end

module JayPT
  class Error < StandardError; end
end
