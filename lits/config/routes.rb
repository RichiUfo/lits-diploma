Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :events, only: [:index, :show] do
    get 'date/:date', to: 'events#date', as: 'events_date'
  end

  root 'events#index'
end
