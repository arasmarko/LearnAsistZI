class TodoController < ApplicationController

	before_action :authenticate_user!
	
	def new
		@step = Step.find(params[:stepId])
		respond_to do |format|
		  	@html_content = render_to_string :partial => 'todo/new'
		  	format.json { render :json => { :html_content => @html_content } }
		end
	end

	def save_new
		todo = ToDo.new(:name => create_todo_params[:name], :step_id => create_todo_params[:step_id])
		todo.save
		redirect_to :back
	end

	def check
		todo = ToDo.find(params[:todoId])
		todo.update(:status => '1')

		step = todo.step
		steps = step.to_dos.count
		stepsDone = step.to_dos.where(:status => "1").count
		if stepsDone > 0
			progress = stepsDone/steps.to_f
		else 
			progress = 0
		end

		render :json => { :success => true , :progress => progress*100, :steps => steps, :stepsDone => stepsDone, :stepId => step.id}
	end

	def uncheck
		todo = ToDo.find(params[:todoId])
		todo.update(:status => '0')
		
		step = todo.step
		steps = step.to_dos.count
		stepsDone = step.to_dos.where(:status => "1").count
		if stepsDone > 0
			progress = stepsDone/steps.to_f
		else 
			progress = 0
		end

		render :json => { :success => true , :progress => progress*100, :steps => steps, :stepsDone => stepsDone, :stepId => step.id}
	end

	private

	def create_todo_params
		params.require(:todo).permit(:name, :step_id)
	end
end