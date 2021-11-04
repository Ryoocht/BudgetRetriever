Rails.application.routes.draw do

  resources :bills, :categories, only: [:index, :new, :create, :show, :edit] do
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
