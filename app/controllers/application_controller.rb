class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ORlabos
  	
  	render :json => { :success => true, :upit => params[:ime] }
  end
  
  def api_test

  	res = {
  		'Marko' => [1,2,3],
  		'ivan' => [4,5,6]
  	}
  	
  	render :json => { :success => true, :upit => 'test', :res => res }

  end

end
