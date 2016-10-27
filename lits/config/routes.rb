Rails.application.routes.draw do
  get 'events/index'

  get 'events/show'

  get 'events/date_show'

  root 'events#index'
end
