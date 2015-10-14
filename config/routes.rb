Rails.application.routes.draw do

   root 'home#home'

   resources :students, :only => [ :index, :create, :update, :show, :destroy, :new, :edit ] do
     get :search
   end

end
