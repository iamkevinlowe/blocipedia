Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :wikis, except: [:new]
  root 'welcome#index'
end
