Rails.application.routes.draw do

  root 'home#home'
  resources :students, :only => [ :index, :create, :update, :show, :destroy, :new, :edit ] do
   get :search
  end
  resources :study_groups, :only => [ :index, :create, :update, :show, :destroy, :new, :edit ]
  # Session management
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
end
