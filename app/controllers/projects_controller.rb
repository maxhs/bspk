class ProjectsController < ApplicationController

	def index
		@projects = Project.all
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.create project_params
		return redirect_to projects_path
	end

	def show
		find_project
	end

	def edit
		find_project
		return redirect_to new_project_path unless @project
	end

	def update
		project
		@project.update project_params
	end

	def destroy
		@project.destroy
	end	

	def prompt
		@prompt = OpenAiService.new.prompt(prompt_params[:prompt])
	end

	private

	def find_project
		@project ||= Project.find_by(id: params[:id])
	end

	def project_params
		params.require(:project).permit(:title, :project_type, training_sets:[])
	end

	def prompt_params
		params.permit(:prompt)
	end
end
