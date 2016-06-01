class NoteController < ApplicationController
	before_action :authenticate_user!
	
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

	private

	def create_note_params
		params.require(:note).permit(:name, :description, :note)
	end
end

