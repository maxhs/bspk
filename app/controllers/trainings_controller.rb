class TrainingsController < ApplicationController

	def new
		@training = Training.new
	end

	def create
		@training = Training.create training_params
		OpenAiService.new(training: @training).upload
	end

	def train
		OpenAiService.new(training: training).fine_tune if training
	end

	def destroy
		return unless training
		@training_id = params[:id] ## store for view manipulation via turbo_stream
		OpenAiService.new(training: training).remove
  	training.file.purge
  	training.destroy
	end

	private

	def training
		@training ||= Training.find_by(id: params[:id])
	end

	def training_params
		params.require(:training).permit(:campaign_id, :file)
	end
end
