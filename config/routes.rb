Rails.application.routes.draw do

  root 'home#home'

  resources :students, :only => [ :index, :create, :update, :show, :destroy, :new, :edit ] do
   get 'search' => 'students#search', on: :collection
  end

  resources :study_groups, :only => [ :index, :create, :update, :show, :destroy, :new, :edit ] do
   get 'search' => 'study_groups#search', on: :collection
  end

  resources :study_sessions, :only => [ :index, :create, :update, :show, :destroy, :new, :edit ] do
   get 'search' => 'study_sessions#search', on: :collection
  end

  # Session management
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
end
