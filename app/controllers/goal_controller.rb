class GoalController < ApplicationController

	before_action :authenticate_user!
	
	def index
		if !params[:id].blank?
			@goals = Goal.where(:id => params[:id])
		else
			@goals = Goal.where(:user_id => current_user.id)
		end
		
	end

	def goal
		redirect_to goals_path(:id => params[:id])
		# @goal = Goal.find(params[:id])
	end

	def delete
		@goal = Goal.find(params[:id]).destroy
		redirect_to goals_path
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

	def create_todo
		todo = ToDo.new( :step_id => params[:step_id], :name => params[:name], :status => "0")
		todo.save
		render :json => { :success => true, :id => todo.id }
	end

	def remove_todo
		todo = ToDo.find(params[:todo_id])
		todo.destroy
		render :json => { :success => true }
	end

	def create_goal
		goal = Goal.new(:name => create_goal_params[:name],:description => create_goal_params[:description], :user_id => current_user.id)
		goal.save
		redirect_to :back
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

	def search
		user = current_user
		goals = []
		steps = []
		searchGoals = params[:search_goals]
		searchSteps = params[:search_steps]
		searchToDos = params[:search_toDos]
		searchResources = params[:search_resources]

		if searchGoals == 'true'
			goals = user.goals.where("name like ?", "%#{params[:search_terms]}%")
		end

		for goal in user.goals
			for step in goal.steps.where("name like ?", "%#{params[:search_terms]}%")
				if !goals.include?(step.goal) && searchSteps == 'true'
					goals.push(step.goal)
				end
			end
			for step in goal.steps
				for todo in step.to_dos.where("name like ?", "%#{params[:search_terms]}%")
					if !goals.include?(todo.step.goal) && searchToDos == 'true'
						goals.push(todo.step.goal)
					end
				end

				for material in step.resources.where("asset_file_name like ?", "%#{params[:search_terms]}%")
					if !goals.include?(material.step.goal) && searchResources == 'true'
						goals.push(material.step.goal)
					end
				end
			end
		end

		respond_to do |format|
		  	@html_content = render_to_string :partial => 'goal/content', :locals => { :goals => goals }
		  	format.json { render :json => { :html_content => @html_content } }
		end

	end

	private

	def create_goal_params
		params.require(:goal).permit(:name,:description)
	end
end

