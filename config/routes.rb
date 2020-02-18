Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  post "search", to: "home#search"
  resources :sites do 
    resources :parse_fields
    member do
      post :test_parse
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

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
