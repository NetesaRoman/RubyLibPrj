Rails.application.routes.draw do

  devise_for :admins






  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "libs_report", to: "report#generate_pdf"
  get "lib_report/:id", to: "report#generate_lib_pdf", as: "lib_report"
  get "libs_csv_report", to: "report#generate_csv"
  get "users_report", to: "report#generate_users_pdf"

  resources :users
  resources :authors
  resources :bibliotekas
  resources :genres
  resources :books
  resources :reader_cards
  resources :main
  resources :report

  root "main#index"
end
