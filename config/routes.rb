Rails.application.routes.draw do

   root 'student#index'

   resources :student, :only => [ :index, :update, :destroy, :show, :create, :show ]

end
