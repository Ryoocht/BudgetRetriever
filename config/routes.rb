Rails.application.routes.draw do
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  
  resources :users, only: [:new, :create]
  resources :accounts, only: [:new, :create] do  
    resources :bills, :categories, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      collection do
        get 'get_category_children'
        get 'get_category_grandchildren'
        get 'get_selected_category'
        patch 'update_category'
        get 'delete_selected_category'
      end
      member do
        get 'get_category_children'
        get 'get_category_grandchildren'
        get 'get_selected_category'
      end
    end
  end
  
end
