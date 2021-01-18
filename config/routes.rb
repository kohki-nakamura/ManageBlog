Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    root 'home#dashboard'
    resources :users do
      collection do
        get "export_csv", format: :csv
      end
    end
    resources :blogs do
      collection do
        get "export_csv", format: :csv
      end
    end
  end
end
