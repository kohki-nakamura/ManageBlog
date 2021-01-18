Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    root 'home#dashboard'
    resources :users
  end
end
