require "ruby_llm"

module JayPT
  class Agent
    attr_reader :model

    def initialize(model: "openai/gpt-4o-mini")
      @model = model
    end

    def score_cve(id)
      cve_data = JayPT::CVE.new(id).fetch

      start_inference_time = Time.now

      analysis = chat.ask <<~PROMPT
        Here is the CVE you are analyzing:

        CVE: #{id}

        #{cve_data.to_json}

        Please analyze the CVE and provide a concise paragraph assessing the likelihood of exploitation in the next 30 days.
      PROMPT

      score = chat.ask("Now, please provide a score between 0.0 and 1.0.")

      {
        score: score.content.to_f,
        analysis: analysis.content,
        inference_time: Time.now - start_inference_time,
        input_tokens: chat.messages.sum { |m| m.input_tokens.to_i },
        output_tokens: chat.messages.sum { |m| m.output_tokens.to_i }
      }
    end

    private

    def chat
      @chat ||= RubyLLM.chat(model:).with_temperature(0.0).tap do |chat|
        system_prompt = File.read(File.join(__dir__, "agent/system_prompt.md"))
        chat.add_message(role: "system", content: system_prompt)
      end
    end
  end
end
