Rails.application.routes.draw do
  resources :restaurants do
    post 'vote', on: :member
  end
end
