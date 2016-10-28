Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'events/index'

  get 'events/show'

  get 'events/date_show'

  root 'events#index'
end
