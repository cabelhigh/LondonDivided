Rails.application.routes.draw do
  devise_for :admins, path_names: {
  sign_up: ''
}
  resources :contracts
  resources :quests
  resources :items
  resources :clues
  resources :teams
  resources :properties

  root 'teams#index'
  get '/sms_log' => "teams#generate_sms_log", as: 'sms_log'
  get '/pick_r' => "teams#pick_random_rosarian", as: 'pick_r'
  get '/pick_l' => "teams#pick_random_lamplighter", as: 'pick_l'
  patch '/send_rs' => "teams#send_rosarians_message", as: 'send_rs'
  patch '/send_ls' => "teams#send_lamplighters_message", as: 'send_ls'
  patch '/payout' => "teams#payout", as: 'payout'
  patch '/send_message/:id' => "teams#send_message", as: 'send_message'
  patch '/buy_prop/:id' => "teams#buy_property", as: 'buy_prop'
  patch '/get_contract/:id' => "teams#get_contract", as: 'get_contract'
  patch '/get_clue/:id' => "teams#get_clue", as: 'get_clue'
  patch '/recieve_quest/:id' => "teams#recieve_quest", as: 'recieve_quest'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
