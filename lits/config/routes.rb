Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks'}

  resources :events, only: [:index, :show] do
    get 'date/:date', to: 'events#date', on: :collection
  end

  root 'events#index'
end
