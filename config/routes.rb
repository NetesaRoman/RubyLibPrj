Rails.application.routes.draw do

  devise_for :admins






  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users
  resources :authors
  resources :bibliotekas
  resources :genres
  resources :books
  resources :reader_cards
  resources :main

  root "main#index"
end
