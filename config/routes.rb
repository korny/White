# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".
White::Application.routes.draw do
  resource :session, only: [:create, :destroy]
  
  resources :sections, only: [], path: '' do
    resources :pages, only: [:show, :update], path: '' do
      resources :images, only: [:create, :update, :destroy] do
        collection do
          patch :reorder
        end
      end
    end
  end
  
  root 'pages#index'
end
