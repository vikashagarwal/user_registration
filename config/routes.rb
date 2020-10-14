Rails.application.routes.draw do

  resources :users, only: [:index, :edit, :update]

  root to: 'users#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  match '*path' => redirect('/'), via: :get
end
