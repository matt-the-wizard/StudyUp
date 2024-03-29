Rails.application.routes.draw do

  root 'home#home'

  resources :students, :only => [ :index, :create, :update, :show, :destroy, :new, :edit ] do
   get 'search' => 'students#search', on: :collection
  end

  resources :study_groups, :only => [ :index, :create, :update, :show, :destroy, :new, :edit ] do
   get 'search' => 'study_groups#search', on: :collection
   get 'join'   => 'study_groups#join',   on: :member
   get 'leave'  => 'study_groups#leave',   on: :member
  end

  resources :study_sessions, :only => [ :index, :create, :update, :show, :destroy, :new, :edit ] do
   get 'search' => 'study_sessions#search', on: :collection
  end

  # Session management
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  namespace :api do
    resources :students, :only => [ :index, :show, :create ] do
      get 'access_profile' => 'students#access_profile', on: :collection
    end
  end
end
