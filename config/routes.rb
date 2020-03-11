Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  post "search", to: "home#search"
  resources :sites do 
    resources :parse_fields
    member do
      post :test_parse
      post :change_status
    end
  end

  resources :parse_items, only: [] do
    member do 
      post :change_status
      post :chosen
    end
    collection do
      get :tagged
    end
  end

  resources :tariffs
  get "/payment/test", to: "payment_sessions#test"
  get "/payment", to: "payment_sessions#payment"
  get "/payment_sessions/success", to: "payment_sessions#success"
  get "/payment_sessions/cancel", to: "payment_sessions#cancel"
  get "/payment/checkout_session", to: "payment_sessions#checkout_session"


  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
