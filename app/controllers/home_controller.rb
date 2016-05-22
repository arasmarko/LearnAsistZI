class HomeController < ApplicationController

	before_action :authenticate_user!

  def index
  	@goals = Goal.where(:user => current_user)
  end

  def search
  end

  def out
  	sign_out @user
  	redirect_to root_path
  end
  
end
