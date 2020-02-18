Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  post 'friendships/accept/:id' => 'friendships#accept', as: 'accept_friend'
  post 'friendships/decline/:id' => 'friendships#decline', as: 'decline_friend'
  post 'friends/cancel/:id' => 'friendships#cancel', as: 'cancel_friend'
  post 'friends/delete/:id' => 'friendships#delete', as: 'delete_friend'

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :friendships

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
