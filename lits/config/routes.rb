Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :events, only: [:index, :show]
  
  get 'events/date/:date', to: 'events#date', as: 'date'

  root 'events#index'
end
