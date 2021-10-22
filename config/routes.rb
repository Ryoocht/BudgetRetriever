Rails.application.routes.draw do
  resources :further_subcategories
  resources :subcategories
  resources :categories
  resources :bills
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
