Rails.application.routes.draw do
  root to: 'operations#index'
  resources :operations, only: %i[index create]
end
