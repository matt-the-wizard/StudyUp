Rails.application.routes.draw do

   root 'student#index'

   resources :students, :only => [ :index, :update, :destroy, :show, :create, :show ]

end
