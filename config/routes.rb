Rails.application.routes.draw do
  get 'upload/create'
  root 'static#home'
  devise_for :users
  get '/dashboard', to: 'dashboard#index'
  get '/upload', to: 'upload#create', as: 'upload_file'
end
