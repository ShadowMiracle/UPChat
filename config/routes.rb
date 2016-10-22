Rails.application.routes.draw do
  get 'friend_ships/new'
  post 'add_friend' => 'friend_ships#create'
  delete 'remove_friend' => 'friend_ships#destroy'

  resources :users

  # resources :messages do
  #   collection do
  #     get 'incoming'
  #     get 'outgoing'
  #   end

  #   member do
  #   end
  # end

  resources :messages, only: [:new, :create]

  get 'conversations/show'
  post 'conversations/mark_as_read'
  get 'conversations/:id' => 'conversations#subscribe'

  resources :sessions, only: [:new, :create]
  delete 'logout' => "sessions#destroy"

  get 'auth/:provider/callback' => 'sessions#callback'

  root 'sessions#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
