# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".
White::Application.routes.draw do
  resources :sections, only: [], path: '' do
    resources :pages, only: [:show, :index], path: '' do
      resources :images, only: [:create]
    end
  end
  
  root 'pages#index'
end
