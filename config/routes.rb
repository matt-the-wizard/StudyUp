Rails.application.routes.draw do

   root 'home#home'

   resources :students, :only => [ :index, :update, :destroy, :show, :create, :show ]

end
