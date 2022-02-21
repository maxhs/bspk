class OpenAiService

	def train

	end

	def prompt(prompt)
		response = client.completions(engine: "text-davinci-001", parameters: { 
			prompt: prompt, 
			max_tokens: 20,
			temperature: 0.6,
			top_p: 1.0,
		  # frequency_penalty: 0.0,
		  # presence_penalty: 0.0
		})
		p "parsed response: #{response.parsed_response}"
    return response.parsed_response["choices"].first["text"]
	end

	private

	def client
		@client ||= OpenAI::Client.new(access_token: Rails.application.credentials.openai.api_key)
	end
end