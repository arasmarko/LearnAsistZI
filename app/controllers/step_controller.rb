class StepController < ApplicationController

	before_action :authenticate_user!
	
	def index
		@step = Step.find(params[:id])
	end

	def new
		@goal = Goal.find(params[:goalId])
		respond_to do |format|
		  	@html_content = render_to_string :partial => 'step/new'
		  	format.json { render :json => { :html_content => @html_content } }
		end
	end

	def create
		step = Step.new(:name => create_post_params[:name], :goal_id => create_post_params[:goal_id])
		step.save
		redirect_to :back
	end

	def new_from_goal
		goalId = params[:goalId]
		name = params[:name]
		step = Step.new(:name => name, :goal_id => goalId)
		step.save
		render :json => { :success => true, :stepId => step.id}
	end

	def delete
		step = Step.find(params[:id])
		step.delete
		render :json => { :success => true }
	end

	def notes
		step = Step.find(params[:id])
		@step = step
		@notes = step.notes
	end

	def get_progress
		stepId = params[:stepId]
		step = Step.find(stepId)
		steps = step.to_dos.count
		stepsDone = step.to_dos.where(:status => "1").count
		if stepsDone > 0
			progress = stepsDone/steps.to_f
		else 
			progress = 0
		end
		

		render :json => { :success => true, :progress => progress*100, :steps => steps, :stepsDone => stepsDone, :stepId => stepId}
	end

	def partial_add_step
		goal = Goal.find(params[:goal])

		respond_to do |format|
		  	@html_content = render_to_string :partial => 'goal/add_step', :locals => {:goal => goal}
		  	format.json { render :json => { :html_content => @html_content } }
		end
		
	end

	def repository
		@step = Step.find(params[:id])
		@resources = Resource.where(:step_id => params[:id])
		
	end

	def add_asset
		resource = Resource.new(asset_params)
		# resource.name = resource.asset_file_name
		# resource.url = '/public/resources/'+resource.name
		if resource.save
			logger.info "saved" + resource.to_yaml
		else
			logger.info "not saved" + resource.to_yaml
		end
		redirect_to :back
	end

	private

	# Use strong_parameters for attribute whitelisting
	# Be sure to update your create() and update() controller methods.

	def asset_params
	  params.require(:resource).permit(:asset, :step_id)
	end

	private

	def create_post_params
		params.require(:step).permit(:name, :goal_id)
	end
end
