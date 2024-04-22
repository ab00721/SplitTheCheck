Rails.application.routes.draw do
  get 'profile/show'
  resources :comments
  resources :votes
  devise_for :users
  root 'restaurants#index', as: 'restaurants_index'

  resources :restaurants do
    post 'vote', on: :member
  end
end
