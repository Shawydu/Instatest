Rails.application.routes.draw do
  devise_for :users
  root 'instas#index'
  resources :instas do
  	resources :comments, only: :create
  end
end
