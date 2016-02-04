Rails.application.routes.draw do
  root 'instas#index'
  resources :instas
end
