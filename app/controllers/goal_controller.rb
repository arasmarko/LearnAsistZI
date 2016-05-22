class GoalController < ApplicationController

	before_action :authenticate_user!
	
	def index
		@goals = Goal.where(:user_id => current_user.id)
	end

	def goal
		@goal = Goal.find(params[:id])
	end

	def delete
		@goal = Goal.find(params[:id]).destroy
		redirect_to :back
	end

	def new
		respond_to do |format|
		  	@html_content = render_to_string :partial => 'goal/new'
		  	format.json { render :json => { :html_content => @html_content } }
		end
	end

	def new_note
		respond_to do |format|
		  	@html_content = render_to_string :partial => 'note/new', :locals => { :step => Step.find(params[:step_id]) }
		  	format.json { render :json => { :html_content => @html_content } }
		end
	end

	def create_note
		step = Step.find( params[:step_id] )
		note = Note.new( create_note_params )
		note.update(:step_id => params[:step_id] )
		redirect_to :back
	end

	def create_goal
		goal = Goal.new(:name => create_goal_params[:name], :user_id => current_user.id)
		goal.save
		redirect_to root_path
	end

	def get_progress
		goal = Goal.find(params[:goal])
		to_dos = 0
		to_dosDone = 0
		progress = 0

		if !goal.steps.blank?
			goal.steps.each do |step|
				to_dos += step.to_dos.count
				to_dosDone += step.to_dos.where(:status => "1").count
			end
		end

		

		if to_dosDone > 0
			progress = to_dosDone/to_dos.to_f
		else
			progress = 0
		end

		
		render :json => { :success => true, :progress => progress, to_dos: to_dos, to_dosDone: to_dosDone}

		
	end

	private

	def create_goal_params
		params.require(:goal).permit(:name)
	end


	def create_note_params
		params.require(:note).permit(:name, :description)
	end
end

