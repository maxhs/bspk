class OpenAiService

	def initialize(training: nil)
		@training = training
	end

	def upload
		@training.file.open do |tempfile|
			response = client.files.upload(parameters: { file: tempfile, purpose: 'fine-tune' })
			p "train response: #{response.inspect}"
	    @training.update(
	    	uploaded_file_id: JSON.parse(response.body)["id"],
	    	uploaded_at: Time.current
    	)
    end
	end

	def remove
		return unless @training.uploaded_file_id.present?
		client.files.delete(id: @training.uploaded_file_id)
	end

	def fine_tune
		return unless @training.uploaded_file_id.present?
		fine_tune_response = client.finetunes.create(
      parameters: {
	      training_file: @training.uploaded_file_id,
	      model: "ada"
	    })
    @training.update(
    	fine_tune_id: JSON.parse(fine_tune_response.body)["id"],
    	trained_at: Time.current
  	)
    p "fine_tune_response: #{fine_tune_response.inspect}"
	end

	def prompt(prompt)
		response = client.completions(engine: "text-davinci-001", parameters: { 
			prompt: prompt, 
			max_tokens: 60,
			temperature: 0.0,
			top_p: 1.0,
		  frequency_penalty: 0.0,
		  presence_penalty: 0.0
		})
		p "parsed response: #{response.parsed_response}"
    return response.parsed_response["choices"].first["text"]
	end

	private

	def client
		@client ||= OpenAI::Client.new(access_token: Rails.application.credentials.openai.api_key)
	end
end