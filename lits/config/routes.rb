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

  # get 'feed', to: 'feed#index', as: :feed
  patch 'feed/:id', to: 'users#update', as: :feed_update
  get 'feed/edit', to: 'users#edit', as: :user_edit

  get 'search', to: 'search#index'
  get 'search(/:q)', to: 'search#search', as: :search_query

  root 'events#index'
end
