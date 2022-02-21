class CampaignsController < ApplicationController

	def index
		@campaigns = Campaign.all
	end

	def new
		@campaign = Campaign.new
	end

	def create
		@campaign = Campaign.create campaign_params
		return redirect_to campaigns_path
	end

	def show
		find_campaign
	end

	def edit
		find_campaign
		return redirect_to new_campaign_path unless @campaign
	end

	def update
		find_campaign
		@campaign.update campaign_params
		return redirect_to edit_campaign_path(@campaign) unless @campaign
	end

	def destroy
		@campaign.destroy
	end

	def train
		training_set = ActiveStorage::Blob.find_signed(params[:id])
		OpenAiService.train(training_set) if training_set
	end

	def prompt
		@prompt = OpenAiService.new.prompt(prompt_params[:params])
		p "prompt response: #{@prompt}"
	end

	def remove_training_set
		@campaign = Campaign.find_by(id: params[:campaign_id])
		training_set = ActiveStorage::Blob.find_signed(params[:id])
  	training_set.purge
	  redirect_to edit_campaign_path(@campaign)
	end

	private

	def find_campaign
		@campaign ||= Campaign.find_by(id: params[:id])
	end

	def campaign_params
		params.require(:campaign).permit(:title, training_sets:[])
	end

	def prompt_params
		params.permit(:prompt)
	end
end
