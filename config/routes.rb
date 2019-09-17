Rails.application.routes.draw do
  resources :drivers
  resources :vehicles
  root 'vehicles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
