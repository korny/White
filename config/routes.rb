# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".
White::Application.routes.draw do
  resources :pages, only: [:show, :index] do
    resources :images, only: [:create]
  end
  
  root 'pages#index'
end
