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

	private

	def update_profile_params
		params.require(:user).permit(:first_name, :last_name, :username, :email)

	end
end
