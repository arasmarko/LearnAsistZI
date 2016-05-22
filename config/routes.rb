Rails.application.routes.draw do

  devise_for :users
	#HOME	
	get '/', :to => 'home#index', :as => 'home'
	get '/search', :to => 'home#search', :as => 'search'
	get '/out', :to => 'home#out', :as => 'out'

	#PROFILE
	get '/profile', :to => 'profile#index', :as => 'profile'
	post '/user-update', :to => 'profile#user_update', :as => 'user_update'
	patch '/user-update-avatar', :to => 'profile#user_update_avatar', :as => 'user_update_avatar'

	#GOAL
	get '/goal/', :to => 'goal#index', :as => 'goals'
	get '/goal/new', :to => 'goal#new', :as => 'new_goal'
	get '/goal/new-note', :to => 'goal#new_note', :as => 'new_note'
	get '/goal/create_goal', :to => 'goal#create_goal', :as => 'create_goal'
	get '/goal/get-progress', :to => 'goal#get_progress', :as => 'goal_get_progress'
	get '/goal/(:id)', :to => 'goal#goal', :as => 'goal'
	get '/goal/delete/(:id)', :to => 'goal#delete', :as => 'delete_goal'
	post '/goal/create_note', :to => 'goal#create_note', :as => 'create_note'

	


	#STEP
	get 'step/new', :to => 'step#new', :as => 'new'
	post 'step/create', :to => 'step#create', :as => 'create_step'
	get 'goal/step/(:id)', :to => 'step#index', :as => 'step'
	post 'step/new_from_goal', :to => 'step#new_from_goal', :as => 'step_new_from_goal'
	get 'step/get-progress', :to => 'step#get_progress', :as => 'step_get_progress'
	get '/step/partial-add-step', :to => 'step#partial_add_step', :as => 'partial_add_step'
	post '/step/delete/(:id)', :to => 'step#delete', :as => 'delete_step'
	get '/step/notes/(:id)', :to => 'step#notes', :as => 'step_notes'


	#TO-DO
	get 'todo/new', :to => 'todo#new', :as => 'todo_new'
	post 'todo/new', :to => 'todo#save_new', :as => 'todo_save_new'
	post 'todo/check', :to => 'todo#check', :as => 'todo_check'
	post 'todo/uncheck', :to => 'todo#uncheck', :as => 'todo_uncheck'

	#recover
	match ':controller(/:action(/:id))', :via => :get

	root to: "home#index"

end
