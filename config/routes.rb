Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :campaigns do
    member do
      delete :delete_training_set
      post :train
      post :prompt
    end
  end
end
