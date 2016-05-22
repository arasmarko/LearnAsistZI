class ProfileController < ApplicationController

	before_action :authenticate_user!
	
	def index
		@user = current_user
	end

	def user_update
		user = current_user
		user.update(update_profile_params)
		redirect_to :back
	end

	def create
	  @user = User.create( user_params )
	end

	def user_update_avatar
		user = current_user
		user.update(user_params)
		redirect_to :back
	end

	private

	def update_profile_params
		params.require(:user).permit(:first_name, :last_name, :username, :email, :avatar)

	end

	# Use strong_parameters for attribute whitelisting
	# Be sure to update your create() and update() controller methods.

	def user_params
	  params.require(:user).permit(:avatar)
	end
end
