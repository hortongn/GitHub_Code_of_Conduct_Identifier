Rails.application.routes.draw do
  root 'repository_sets#index'
  resources :repository_loaders
  resources :repository_sets
  resources :code_of_conduct_types
  resources :code_of_conducts
  resources :repositories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "find_codes_of_conduct/:repository_set_id", to: "repository_sets#find_codes_of_conduct", as: "find_codes_of_conduct"

  get "code_of_conduct_sets/:repository_set_id", to: "code_of_conducts#set", as: "code_of_conduct_sets"

end
