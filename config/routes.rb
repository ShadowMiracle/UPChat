Rails.application.routes.draw do
  resources :users

  resources :sessions, only: [:new, :create]
  delete 'logout' => "sessions#destroy"

  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
