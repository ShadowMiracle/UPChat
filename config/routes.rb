Rails.application.routes.draw do
  get 'friend_ships/new'
  post 'add_friend' => 'friend_ships#create'
  delete 'remove_friend' => 'friend_ships#destroy'

  resources :users

  resources :messages do
    collection do
      get 'incoming'
      get 'outgoing'
    end

    member do
      post 'mark_as_read'
      get 'index'
    end
  end

  get 'conversations/show'

  resources :sessions, only: [:new, :create]
  delete 'logout' => "sessions#destroy"

  get 'auth/:provider/callback' => 'sessions#callback'

  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
