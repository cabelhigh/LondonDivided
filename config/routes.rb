Rails.application.routes.draw do
  devise_for :admins, path_names: {
  sign_up: ''
}
  resources :contracts
  resources :quests
  resources :items
  resources :clues
  resources :checkpoints
  resources :teams
  resources :properties

  root 'teams#index'
  patch '/buy_prop/:id' => "teams#buy_property", as: 'buy_prop'
  patch '/get_clue/:id' => "teams#get_clue", as: 'get_clue'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
