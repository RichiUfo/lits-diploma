Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  namespace :admin, path: 'topsecret' do
    resources :sources
    root to: 'index#index'
  end

  resources :events, only: [:index, :show] do
    get 'index(/:page)', to: 'events#index', on: :collection
    get 'date/:date', to: 'events#date', on: :collection, as: :events_date
  end

  resources :tags, only: [:index, :show] do
    get ':id(/:page)', to: 'tags#show', on: :collection
  end

  get 'feed', to: 'feed#index', as: :feed
  get 'feed/edit', to: 'feed#edit', as: :feed_edit

  get 'search', to: 'search#index'
  get 'search(/:q)', to: 'search#search', as: :search_query

  root 'events#index'
end
