Rails.application.routes.draw do
  resource :session, only: [:create, :destroy]
  
  resources :sections, only: [:create, :update, :destroy], path: '' do
    resources :pages, only: [:show, :create, :update, :destroy], path: '' do
      resources :images, only: [:create, :update, :destroy] do
        patch :reorder, on: :collection
      end
      patch :reorder, on: :collection
    end
    patch :reorder, on: :collection
  end
  
  root 'pages#index'
end
