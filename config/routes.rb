Rails.application.routes.draw do
  root 'restaurants#index', as: 'restaurants_index'

  resources :restaurants do
    post 'vote', on: :member
  end
end
