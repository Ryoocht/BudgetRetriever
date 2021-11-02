Rails.application.routes.draw do
  get 'practice/index'
  # resources :categories
  resources :bills, :categories, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    collection do
      get 'get_category_children'
      get 'get_category_grandchildren'
    end
    member do
      get 'get_category_children'
      get 'get_category_grandchildren'
    end
  end

end
