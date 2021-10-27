Rails.application.routes.draw do
  get 'practice/index'
  resources :categories
  resources :bills, only: [:index, :new, :create, :show, :edit, :destroy] do
    collection do
      get 'get_category_children'
      get 'get_category_grandchildren'
    end
  end

end
