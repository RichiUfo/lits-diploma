Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  namespace :admin do
    resources :sources
  end

  resources :events, only: [:index, :show] do
    get 'index(/:page)', to: 'events#index', on: :collection
    get 'date/:date', to: 'events#date', on: :collection
  end

  resources :tags, only: [:index, :show]

  get 'feed', to: 'feed#index', as: :feed
  get 'feed/edit', to: 'feed#edit', as: :feed_edit

  root 'events#index'
end
