Rails.application.routes.draw do
  resources :repository_sets
  resources :code_of_conduct_types
  resources :code_of_conducts
  resources :repositories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
