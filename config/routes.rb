# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :details, only: [:index]
  resources :projects do
    resource :detail, only: [:show, :edit, :update]
  end
end
