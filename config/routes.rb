Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :campaigns do
    member do
      post :prompt
    end
  end
  resources :trainings do
    member do
      post :train
    end
  end
end
