Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :sale_records, only: [:index]
  end
end
