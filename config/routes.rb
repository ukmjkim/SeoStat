Rails.application.routes.draw do
  resources :rankings do
    collection { post :import }
  end
  root 'rankings#index'
end
