Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :aggregators do
    resources :sites, only: [:index, :new, :create]
  end

  resources :sites, only: [:show, :edit, :update, :destroy] do 
    member do
      get :test_parse
      patch :change_status
    end

    resources :parse_fields
    resources :parse_items, only: [] do
      member do 
        patch :change_status
        patch :chosen
      end
      collection do
        get :tagged
      end
    end
  end

  resources :tariffs
  get "/payment_sessions/success", to: "payment_sessions#success"
  get "/payment_sessions/cancel", to: "payment_sessions#cancel"
  get "/payment/checkout_session", to: "payment_sessions#checkout_session"


  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  namespace :rails_admin do
    get "/tariff/:id/stripe/add", to: "tariffs#add"
    delete "/tariff/:id/stripe/delete", to: "tariffs#delete"
    put "/tariff/:id/stripe/update", to: "tariffs#update"
  end
end
