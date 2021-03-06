Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations'}
  resources :users, only: [:show, :update]
  resources :wikis, except: [:new]
  resources :charges, only: [:new, :create]
  resources :collaborators, only: [:create, :destroy]
  root 'welcome#index'
end
