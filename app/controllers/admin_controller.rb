class AdminController < ApplicationController

	before_action :authenticate_admin!

	def index
		@users = User.all
	end

	def delete_user
		User.find(params[:id]).destroy
		redirect_to :back
	end

end
